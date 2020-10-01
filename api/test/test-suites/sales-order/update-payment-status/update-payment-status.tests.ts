import axios from 'axios';
import { getCredentials } from '../../utils/credentials';
import { cleanUpDatabase, executeQuery } from '../../utils/queries';
import { createSaleOrders } from '../sales-order.fixtures';
import { SaleOrder } from '../../../../src/sales-order/entities/sale-order.entity';

describe('update sale order payment status', () => {
  let authorizedRequest: any;

  beforeAll(async () => {
    authorizedRequest = await getCredentials();

    await cleanUpDatabase();

    await createSaleOrders();
  });

  async function changeOrderStatus(reference, status) {
    const beforeRequest = Date.now();
    const response = await axios.post(
      `http://localhost:3005/v1/sales-order/${reference}`,
      { status },
      authorizedRequest,
    );

    expect(response).toBeDefined();
    expect(response.data).toBeDefined();
    expect(response.status).toBe(201);

    const saleOrderCreated: SaleOrder = response.data;
    expect(saleOrderCreated.id).toBeDefined();
    expect(saleOrderCreated.referenceCode).toBe(reference);
    expect(saleOrderCreated.paymentDetails.paymentStatus).toBe(status);

    if (status === 'CANCELLED') {
      expect(saleOrderCreated.cancellationDate.toString()).toBeDefined();
      expect(
        Date.parse(saleOrderCreated.cancellationDate.toString()),
      ).toBeGreaterThan(beforeRequest);
    }

    if (status === 'APPROVED') {
      expect(saleOrderCreated.approvalDate.toString()).toBeDefined();
      expect(
        Date.parse(saleOrderCreated.approvalDate.toString()),
      ).toBeGreaterThan(beforeRequest);
    }
  }

  it('should update sale order payment status', async () => {
    const orders = await executeQuery(
      `select reference_code as reference from sale_order;`,
    );

    await changeOrderStatus(orders[0].reference, 'APPROVED');
    await changeOrderStatus(orders[1].reference, 'APPROVED');

    await changeOrderStatus(orders[0].reference, 'CANCELLED');
    await changeOrderStatus(orders[1].reference, 'CANCELLED');
  });
});
