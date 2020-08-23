import axios from 'axios';
import { getCredentials } from '../../utils/credentials';
import { cleanUpDatabase } from '../../../test-suites/utils/queries';

import { createSaleOrders } from '../sales-order.fixtures';
import saleOrderScenarios from '../sales-order.scenarios.json';
import { insertProductFixtures } from '../../products/products-fixtures/products.fixture';

describe('querying sale orders', () => {
  let authorizedRequest: any;

  beforeAll(async () => {
    authorizedRequest = await getCredentials();

    await cleanUpDatabase();

    await insertProductFixtures();
    await createSaleOrders();
  });

  it('should be able to query sale orders', async () => {
    const response = await axios.get(
      'http://localhost:3005/v1/sales-order?page=1&limit=3',
      authorizedRequest,
    );

    expect(response).toBeDefined();
    expect(response.data).toBeDefined();
    expect(response.status).toBe(200);

    const result = response.data;
    expect(result.items.length).toBe(3);

    expect(result.items[0].customer).toBeDefined();
    expect(result.items[0].customer.name).toBe(
      saleOrderScenarios[4].customer.name,
    );
    expect(result.items[0].items.length).toBe(
      saleOrderScenarios[4].items.length,
    );

    expect(result.items[1].customer).toBeDefined();
    expect(result.items[1].customer.name).toBe(
      saleOrderScenarios[3].customer.name,
    );
    expect(result.items[1].items.length).toBe(
      saleOrderScenarios[3].items.length,
    );

    expect(result.items[2].customer).toBeDefined();
    expect(result.items[2].customer.name).toBe(
      saleOrderScenarios[2].customer.name,
    );
    expect(result.items[2].items.length).toBe(
      saleOrderScenarios[2].items.length,
    );

    const responsePage2 = await axios.get(
      'http://localhost:3005/v1/sales-order?page=2&limit=3',
      authorizedRequest,
    );

    expect(responsePage2).toBeDefined();
    expect(responsePage2.data).toBeDefined();
    expect(responsePage2.status).toBe(200);

    const resultPage2 = responsePage2.data;
    expect(resultPage2.items.length).toBe(2);

    expect(resultPage2.items[0].customer).toBeDefined();
    expect(resultPage2.items[0].customer.name).toBe(
      saleOrderScenarios[1].customer.name,
    );
    expect(resultPage2.items[0].items.length).toBe(
      saleOrderScenarios[1].items.length,
    );

    expect(resultPage2.items[1].customer).toBeDefined();
    expect(resultPage2.items[1].customer.name).toBe(
      saleOrderScenarios[0].customer.name,
    );
    expect(resultPage2.items[1].items.length).toBe(
      saleOrderScenarios[0].items.length,
    );
  });

  it('should be able to query sale orders by customers', async () => {
    const response = await axios.get(
      'http://localhost:3005/v1/sales-order?page=1&limit=3&query=helena',
      authorizedRequest,
    );

    expect(response).toBeDefined();
    expect(response.data).toBeDefined();
    expect(response.status).toBe(200);

    const result = response.data;
    expect(result.items.length).toBe(1);

    expect(result.items[0].customer).toBeDefined();
    expect(result.items[0].customer.name).toBe(
      saleOrderScenarios[4].customer.name,
    );
    expect(result.items[0].items.length).toBe(
      saleOrderScenarios[4].items.length,
    );

    const responseKrebs = await axios.get(
      'http://localhost:3005/v1/sales-order?page=1&limit=3&query=krebs',
      authorizedRequest,
    );

    expect(responseKrebs).toBeDefined();
    expect(responseKrebs.data).toBeDefined();
    expect(responseKrebs.status).toBe(200);

    const resultKrebs = responseKrebs.data;
    expect(resultKrebs.items.length).toBe(2);

    expect(resultKrebs.items[0].customer).toBeDefined();
    expect(resultKrebs.items[0].customer.name).toBe(
      saleOrderScenarios[3].customer.name,
    );
    expect(resultKrebs.items[0].items.length).toBe(
      saleOrderScenarios[3].items.length,
    );

    expect(resultKrebs.items[1].customer).toBeDefined();
    expect(resultKrebs.items[1].customer.name).toBe(
      saleOrderScenarios[0].customer.name,
    );
    expect(resultKrebs.items[1].items.length).toBe(
      saleOrderScenarios[0].items.length,
    );
  });

  it('should be able to query sale orders by payment status', async () => {
    const responseApproved = await axios.get(
      'http://localhost:3005/v1/sales-order?page=1&limit=3&paymentStatus=APPROVED',
      authorizedRequest,
    );

    const resultApproved = responseApproved.data;
    expect(resultApproved.items.length).toBe(2);

    expect(resultApproved.items[0].paymentStatus).toBe('APPROVED');
    expect(resultApproved.items[1].paymentStatus).toBe('APPROVED');

    const responseCancelled = await axios.get(
      'http://localhost:3005/v1/sales-order?page=1&limit=3&paymentStatus=CANCELLED',
      authorizedRequest,
    );

    const resultCancelled = responseCancelled.data;
    expect(resultCancelled.items.length).toBe(1);

    expect(resultCancelled.items[0].paymentStatus).toBe('CANCELLED');

    const responseInProcess = await axios.get(
      'http://localhost:3005/v1/sales-order?page=1&limit=3&paymentStatus=IN_PROCESS',
      authorizedRequest,
    );

    const resultInProcess = responseInProcess.data;
    expect(resultInProcess.items.length).toBe(2);

    expect(resultInProcess.items[0].paymentStatus).toBe('IN_PROCESS');
    expect(resultInProcess.items[1].paymentStatus).toBe('IN_PROCESS');
  });
});
