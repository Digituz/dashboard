import { Injectable } from '@nestjs/common';
import { j2xParser as XMLParser } from 'fast-xml-parser';
import moment from 'moment';
import { SaleOrder } from '../sales-order/entities/sale-order.entity';

@Injectable()
export class BlingService {
  async createPurchaseOrder(saleOrder: SaleOrder) {
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

    // items.forEach(item => {
    //   //   const finalPrice = item.product.promotionalPrice || item.product.sellingPrice;
    //   const finalPrice = item.price - item.discount;
    //   const itemSold = {
    //     item: {
    //       codigo: item.product.sku,
    //       descricao: item.product.title,
    //       un: 'Un',
    //       qtde: item.amount,
    //       vlr_unit: finalPrice,
    //     },
    //   };
    //   if (item.product.sizeGrid)
    //     itemSold.item.descricao += ` - Tamanho ${item.product.sizeGrid}`;
    //   order.itens.push(itemSold);
    // });

    // for (let i = 0; i < paymentDetails.installmentQuantity; i++) {
    //   const installmentDate = moment().add(i, 'M');
    //   order.parcelas.push({
    //     parcela: {
    //       data: installmentDate.format('DD/MM/YYYY'),
    //       vlr: paymentDetails.installmentValue,
    //     },
    //   });
    // }

    // const parser = new XMLParser({});
    // const xml = parser.parse({
    //   pedido: order,
    // });

    // if (production) {
    //   await request.post({
    //     url: 'https://bling.com.br/Api/v2/pedido/json/',
    //     headers: {
    //       'Content-Type': 'application/x-www-form-urlencoded',
    //     },
    //     formData: {
    //       xml: xml,
    //       apikey: process.env.BLING_APIKEY,
    //     },
    //   });
    // }
  }
}
