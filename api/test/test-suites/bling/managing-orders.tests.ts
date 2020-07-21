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

  it('should be able to manage products on Bling', async () => {
    const product: Product = {
      sku: `ZZ-${Date.now()}`,
      title: 'Produto Teste',
      sellingPrice: 39.9,
      ncm: '1234.56.78',
      isActive: true,
      imagesSize: 0,
      variationsSize: 1,
      withoutVariation: false,
    }

    const productVariation: ProductVariation = {
      product: product,
      sku: `ZZ-${Date.now()}-15`,
      description: 'Tamanho:15',
      sellingPrice: 39.9,
    };

    // create the product on Bling
    const createHttpResponse = await realBlingService.createOrUpdateProduct(productVariation);
    const createResponse = await createHttpResponse.toPromise();
    expect(createResponse).toBeDefined();
    expect(createResponse.data).toBeDefined();
    expect(createResponse.data.retorno.erros).toBeUndefined();
    expect(createResponse.status).toBe(201);

    // remove product from Bling
    const removeHttpResponse = await realBlingService.removeProduct(productVariation);
    const removeResponse = await removeHttpResponse.toPromise();
    expect(removeResponse).toBeDefined();
    expect(removeResponse.data).toBeDefined();
    expect(removeResponse.data.indexOf('deletado com sucesso')).toBeGreaterThan(0);
    expect(removeResponse.status).toBe(200);
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
      withoutVariation: false,
    }

    const productVariation: ProductVariation = {
      product: product,
      sku: `ZZ-${Date.now()}-15`,
      description: 'Tamanho:15',
      sellingPrice: 39.9,
    };

    // create the product on Bling
    const firstHttpResponse = await realBlingService.createOrUpdateProduct(productVariation);
    const firstResponse = await firstHttpResponse.toPromise();
    expect(firstResponse).toBeDefined();
    expect(firstResponse.data).toBeDefined();
    expect(firstResponse.data.retorno.erros).toBeUndefined();
    expect(firstResponse.status).toBe(201);

    // create the product on Bling
    const secondHttpResponse = await realBlingService.createOrUpdateProduct(productVariation);
    const secondResponse = await secondHttpResponse.toPromise();
    expect(secondResponse).toBeDefined();
    expect(secondResponse.data).toBeDefined();
    expect(secondResponse.data.retorno.erros).toBeUndefined();
    expect(secondResponse.status).toBe(201);

    // remove product from Bling
    const removeHttpResponse = await realBlingService.removeProduct(productVariation);
    const removeResponse = await removeHttpResponse.toPromise();
    expect(removeResponse).toBeDefined();
    expect(removeResponse.data).toBeDefined();
    expect(removeResponse.data.indexOf('deletado com sucesso')).toBeGreaterThan(0);
    expect(removeResponse.status).toBe(200);
  });

  it('should be able to manage purchase orders on Bling', async () => {
    // prepare order details
    const saleOrder: any = scenarios[0];
    saleOrder.paymentDetails.paymentStatus =
      PaymentStatus[saleOrder.paymentDetails.paymentStatus];
    saleOrder.paymentDetails.paymentType =
      PaymentType[saleOrder.paymentDetails.paymentType];
    saleOrder.shipmentDetails.shippingType =
      ShippingType[saleOrder.shipmentDetails.shippingType];
    saleOrder.referenceCode = randomize('0', 10);

    // create the order on Bling
    const createHttpResponse = await realBlingService.createPurchaseOrder(saleOrder);
    const createResponse = await createHttpResponse.toPromise();
    expect(createResponse).toBeDefined();
    expect(createResponse.data).toBeDefined();
    expect(createResponse.data.retorno.erros).toBeUndefined();
    expect(createResponse.status).toBe(201);

    // cancel the order on Bling
    saleOrder.paymentDetails.paymentStatus = PaymentStatus.CANCELLED;
    const cancelHttpResponse = await realBlingService.cancelPurchaseOrder(saleOrder);
    const cacnelResponse = await cancelHttpResponse.toPromise();
    expect(cacnelResponse).toBeDefined();
    expect(cacnelResponse.data).toBeDefined();
    expect(cacnelResponse.data.retorno.erros).toBeUndefined();
    expect(cacnelResponse.status).toBe(200);
  });
});
