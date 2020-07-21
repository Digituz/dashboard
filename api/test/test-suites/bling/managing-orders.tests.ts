import axios from 'axios';
import { HttpService } from '@nestjs/common';
import { BlingService } from '../../../src/bling/bling.service';

import scenarios from './bling-sales-orders.scenarios.json';
import { PaymentStatus } from '../../../src/sales-order/entities/payment-status.enum';
import { PaymentType } from '../../../src/sales-order/entities/payment-type.enum';
import { ShippingType } from '../../../src/sales-order/entities/shipping-type.enum';

describe('Bling integration', () => {
  it('should be able to create purchase orders on Bling', async () => {
    const realBlingService = new BlingService(new HttpService(axios));

    const saleOrder: any = scenarios[0];
    saleOrder.paymentDetails.paymentStatus =
      PaymentStatus[saleOrder.paymentDetails.paymentStatus];
    saleOrder.paymentDetails.paymentType =
      PaymentType[saleOrder.paymentDetails.paymentType];
    saleOrder.shipmentDetails.shippingType =
      ShippingType[saleOrder.shipmentDetails.shippingType];
    
    const httpResponse = await realBlingService.createPurchaseOrder(saleOrder);

    const response = await httpResponse.toPromise();

    expect(response).toBeDefined();
    expect(response.data).toBeDefined();
    expect(response.data.retorno.erros).toBeUndefined();
    expect(response.status).toBe(201);
  });
});
