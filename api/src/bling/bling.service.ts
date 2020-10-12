import { Injectable, HttpService } from '@nestjs/common';
import { j2xParser as XMLParser } from 'fast-xml-parser';
import moment from 'moment';
import qs from 'qs';

import { SaleOrder } from '../sales-order/entities/sale-order.entity';
import { PaymentStatus } from '../sales-order/entities/payment-status.enum';
import { ProductVariation } from '../products/entities/product-variation.entity';

@Injectable()
export class BlingService {
  parser = new XMLParser({});

  constructor(private httpService: HttpService) {}

  async removeProduct(productVariation: ProductVariation) {
    const data = {
      apikey: process.env.BLING_APIKEY,
    };

    return this.httpService.delete(
      `https://bling.com.br/Api/v2/produto/${productVariation.sku}`,
      {
        data: qs.stringify(data),
      },
    );
  }

  async createOrUpdateProduct(productVariation: ProductVariation) {
    const xml = this.parser.parse({
      produto: {
        codigo: productVariation.sku,
        descricao: `${productVariation.product.title} ${productVariation.description}`,
        class_fiscal: productVariation.product.ncm,
        un: 'Un',
        vlr_unit: productVariation.sellingPrice,
        origem: 0, // origem conforme ICMS (0 = nacional ...) TODO cadastrar origem nos produtos
      },
    });

    const data = {
      xml: xml,
      apikey: process.env.BLING_APIKEY,
    };

    return this.httpService.post(
      'https://bling.com.br/Api/v2/produto/json/',
      qs.stringify(data),
    );
  }

  async createPurchaseOrder(saleOrder: SaleOrder) {
    if (saleOrder.paymentDetails.paymentStatus !== PaymentStatus.APPROVED) {
      throw new Error(
        'We should only create purchase orders that have payment approved.',
      );
    }

    const { customer, shipmentDetails, items } = saleOrder;

    const order = {
      numero: saleOrder.referenceCode,
      cliente: {
        nome: customer.name,
        fone: customer.phoneNumber,
        cpf_cnpj: customer.cpf,
        email: customer.email,
        tipoPessoa: 'F',
        endereco: customer.streetAddress,
        numero: customer.streetNumber,
        complemento: customer.streetNumber2,
        bairro: customer.neighborhood,
        cep: customer.zipAddress,
        cidade: customer.city,
        uf: customer.state,
      },
      transporte: {
        transportadora: shipmentDetails.shippingType,
        tipo_frete: 'D',
        servico_correios: shipmentDetails.shippingType,
        dados_etiqueta: {
          nome: shipmentDetails.customerName,
          endereco: shipmentDetails.shippingStreetAddress,
          numero: shipmentDetails.shippingStreetNumber,
          complemento: shipmentDetails.shippingStreetNumber2,
          municipio: shipmentDetails.shippingCity,
          uf: shipmentDetails.shippingState,
          cep: shipmentDetails.shippingZipAddress,
          bairro: shipmentDetails.shippingNeighborhood,
        },
        volumes: [
          {
            volume: {
              servico: shipmentDetails.shippingType,
            },
          },
        ],
      },
      itens: [],
      parcelas: [],
      vlr_frete: shipmentDetails.shippingPrice,
      vlr_desconto: saleOrder.paymentDetails.discount,
    };

    items.forEach(item => {
      const finalPrice = item.price - item.discount;
      const itemSold = {
        item: {
          codigo: item.productVariation.sku,
          descricao: item.productVariation.product.title,
          un: 'Un',
          qtde: item.amount,
          vlr_unit: finalPrice,
        },
      };
      if (item.productVariation.description) {
        itemSold.item.descricao += ` - Tamanho ${item.productVariation.description}`;
      }
      order.itens.push(itemSold);
    });

    for (let i = 0; i < saleOrder.paymentDetails.installments; i++) {
      const installmentDate = moment().add(i, 'M');
      order.parcelas.push({
        parcela: {
          data: installmentDate.format('DD/MM/YYYY'),
          vlr:
            saleOrder.paymentDetails.total /
            saleOrder.paymentDetails.installments,
        },
      });
    }

    const xml = this.parser.parse({
      pedido: order,
    });

    const data = {
      xml: xml,
      apikey: process.env.BLING_APIKEY,
    };

    const syncRequest = await this.httpService.post(
      'https://bling.com.br/Api/v2/pedido/json/',
      qs.stringify(data),
    );

    const response = await syncRequest.toPromise();

    return Promise.resolve(response);
  }

  async cancelPurchaseOrder(saleOrder: SaleOrder) {
    const xml = this.parser.parse({
      pedido: {
        idSituacao: 12, // more info: https://ajuda.bling.com.br/hc/pt-br/articles/360046304394-GET-situacao-m%C3%B3dulo-
      },
    });

    const data = {
      xml: xml,
      apikey: process.env.BLING_APIKEY,
    };

    return this.httpService
      .put(
        `https://bling.com.br/Api/v2/pedido/${saleOrder.referenceCode}/json/`,
        qs.stringify(data),
      )
      .toPromise();
  }
}
