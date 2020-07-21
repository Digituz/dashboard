import axios from 'axios';
import { HttpService } from '@nestjs/common';
import { BlingService } from '../../../src/bling/bling.service';
import randomize from 'randomatic';

import scenarios from './bling-sales-orders.scenarios.json';
import { PaymentStatus } from '../../../src/sales-order/entities/payment-status.enum';
import { PaymentType } from '../../../src/sales-order/entities/payment-type.enum';
import { ShippingType } from '../../../src/sales-order/entities/shipping-type.enum';

describe('Bling integration', () => {
  it('should be able to manage purchase orders on Bling', async () => {
    const realBlingService = new BlingService(new HttpService(axios));

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
