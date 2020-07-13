import axios from 'axios';
import { getCredentials } from '../../utils/credentials';
import { insertProductFixtures } from '../../products/products-fixtures/products.fixture';
import { cleanUpDatabase, executeQuery } from '../../../test-suites/utils/queries';

import saleOrderScenarios from '../sales-order.scenarios.json';
import { SaleOrderDTO } from '../../../../src/sales-order/sale-order.dto';
import { SaleOrder } from '../../../../src/sales-order/entities/sale-order.entity';

describe('creating sale orders', () => {
  let authorizedRequest: any;

  beforeAll(async () => {
    authorizedRequest = await getCredentials();

    await cleanUpDatabase();

    await insertProductFixtures();
  });

  saleOrderScenarios.forEach((saleOrder: SaleOrderDTO, idx: number) => {
    it(`should create sale orders (scenario #${idx})`, async () => {
      const response = await axios.post(
        'http://localhost:3000/v1/sales-order',
        saleOrder,
        authorizedRequest,
      );

      expect(response).toBeDefined();
      expect(response.data).toBeDefined();
      expect(response.status).toBe(201);
      
      const saleOrderCreated: SaleOrder = response.data;
      expect(saleOrderCreated.id).toBeDefined();
      expect(saleOrderCreated.referenceCode).toBeDefined();
      expect(saleOrderCreated.referenceCode.length).toBe(36);
      expect(saleOrderCreated.customer.name).toBe(saleOrder.customer.name);
      expect(saleOrderCreated.items.length).toBe(saleOrder.items.length);
      expect(saleOrderCreated.paymentDetails.discount).toBe(saleOrder.discount);
      expect(saleOrderCreated.paymentDetails.paymentType).toBe(saleOrder.paymentType);
      expect(saleOrderCreated.paymentDetails.paymentStatus).toBe(saleOrder.paymentStatus);
      expect(saleOrderCreated.paymentDetails.installments).toBe(saleOrder.installments);
      expect(saleOrderCreated.shipmentDetails.shippingType).toBe(saleOrder.shippingType);
      expect(saleOrderCreated.shipmentDetails.shippingPrice).toBe(saleOrder.shippingPrice);
      expect(saleOrderCreated.shipmentDetails.customerName).toBe(saleOrder.customerName);
      expect(saleOrderCreated.shipmentDetails.shippingStreetAddress).toBe(saleOrder.shippingStreetAddress);
      expect(saleOrderCreated.shipmentDetails.shippingStreetNumber).toBe(saleOrder.shippingStreetNumber);
      expect(saleOrderCreated.shipmentDetails.shippingStreetNumber2).toBe(saleOrder.shippingStreetNumber2);
      expect(saleOrderCreated.shipmentDetails.shippingNeighborhood).toBe(saleOrder.shippingNeighborhood);
      expect(saleOrderCreated.shipmentDetails.shippingCity).toBe(saleOrder.shippingCity);
      expect(saleOrderCreated.shipmentDetails.shippingState).toBe(saleOrder.shippingState);
      expect(saleOrderCreated.shipmentDetails.shippingZipAddress).toBe(saleOrder.shippingZipAddress.replace(/\D/g,''));
    });
  });
});
