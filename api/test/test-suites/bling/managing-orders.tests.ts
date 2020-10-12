import axios from 'axios';
import { HttpService } from '@nestjs/common';
import { BlingService } from '../../../src/bling/bling.service';
import randomize from 'randomatic';

import scenarios from './bling-sales-orders.scenarios.json';
import { PaymentStatus } from '../../../src/sales-order/entities/payment-status.enum';
import { PaymentType } from '../../../src/sales-order/entities/payment-type.enum';
import { ShippingType } from '../../../src/sales-order/entities/shipping-type.enum';
import { Product } from '../../../src/products/entities/product.entity';
import { ProductVariation } from '../../../src/products/entities/product-variation.entity';

describe('Bling integration', () => {
  const realBlingService = new BlingService(new HttpService(axios));

  async function createOrUpdateProduct(productVariation: ProductVariation) {
    const httpResponse = await realBlingService.createOrUpdateProduct(
      productVariation,
    );
    const response = await httpResponse.toPromise();
    expect(response).toBeDefined();
    expect(response.data).toBeDefined();
    expect(response.data.retorno.erros).toBeUndefined();
    expect(response.status).toBe(201);
  }

  async function removeProduct(productVariation: ProductVariation) {
    const removeHttpResponse = await realBlingService.removeProduct(
      productVariation,
    );
    const removeResponse = await removeHttpResponse.toPromise();
    expect(removeResponse).toBeDefined();
    expect(removeResponse.data).toBeDefined();
    expect(removeResponse.data.indexOf('deletado com sucesso')).toBeGreaterThan(
      0,
    );
    expect(removeResponse.status).toBe(200);
  }

  it('should be able to manage products on Bling', async () => {
    const product: Product = {
      sku: `ZZ-${Date.now()}`,
      title: 'Produto Teste',
      sellingPrice: 39.9,
      ncm: '1234.56.78',
      isActive: true,
      imagesSize: 0,
      variationsSize: 1,
    };

    const productVariation: ProductVariation = {
      product: product,
      sku: `ZZ-${Date.now()}-15`,
      description: 'Tamanho:15',
      sellingPrice: 39.9,
    };

    // create the product on Bling
    await createOrUpdateProduct(productVariation);

    // remove product from Bling
    await removeProduct(productVariation);
  });

  it('should be able to update products', async () => {
    const product: Product = {
      sku: `ZZ-${Date.now()}`,
      title: 'Produto Teste',
      sellingPrice: 39.9,
      ncm: '1234.56.78',
      isActive: true,
      imagesSize: 0,
      variationsSize: 1,
    };

    const productVariation: ProductVariation = {
      product: product,
      sku: `ZZ-${Date.now()}-15`,
      description: 'Tamanho:15',
      sellingPrice: 39.9,
    };

    // create the product on Bling
    await createOrUpdateProduct(productVariation);

    // update the product on Bling
    await createOrUpdateProduct(productVariation);

    // remove product from Bling
    await removeProduct(productVariation);
  });

  it('should be able to manage purchase orders on Bling', async () => {
    const product: Product = {
      sku: `ZZ-${Date.now()}`,
      title: 'Produto Teste',
      sellingPrice: 39.9,
      ncm: '6307.90.10',
      isActive: true,
      imagesSize: 0,
      variationsSize: 1,
    };

    const productVariation: ProductVariation = {
      product: product,
      sku: `ZZ-${Date.now()}-15`,
      description: 'Tamanho:15',
      sellingPrice: 39.9,
    };

    // create the product on Bling
    await createOrUpdateProduct(productVariation);

    // prepare order details
    const saleOrder: any = scenarios[0];
    saleOrder.paymentDetails.paymentStatus =
      PaymentStatus[saleOrder.paymentDetails.paymentStatus];
    saleOrder.paymentDetails.paymentType =
      PaymentType[saleOrder.paymentDetails.paymentType];
    saleOrder.shipmentDetails.shippingType =
      ShippingType[saleOrder.shipmentDetails.shippingType];
    saleOrder.referenceCode = randomize('0', 10);

    saleOrder.items[0].productVariation = productVariation;

    // create the order on Bling
    const createResponse = await realBlingService.createPurchaseOrder(
      saleOrder,
    );
    expect(createResponse).toBeDefined();
    expect(createResponse.data).toBeDefined();
    expect(createResponse.data.retorno.erros).toBeUndefined();
    expect(createResponse.status).toBe(201);

    // cancel the order on Bling
    saleOrder.paymentDetails.paymentStatus = PaymentStatus.CANCELLED;
    const cancelResponse = await realBlingService.cancelPurchaseOrder(
      saleOrder,
    );
    expect(cancelResponse).toBeDefined();
    expect(cancelResponse.data).toBeDefined();
    expect(cancelResponse.data.retorno.erros).toBeUndefined();
    expect(cancelResponse.status).toBe(200);

    // remove product from Bling
    await removeProduct(productVariation);
  });
});
