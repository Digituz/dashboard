import axios from 'axios';
import { getCredentials } from '../../utils/credentials';
import {
  cleanUpDatabase,
  executeQuery,
} from '../../../test-suites/utils/queries';

import { createSaleOrders } from '../sales-order.fixtures';

describe('querying sale orders', () => {
  let authorizedRequest: any;

  beforeAll(async () => {
    authorizedRequest = await getCredentials();

    await cleanUpDatabase();

    await createSaleOrders();
  });

  it('should be able to query sale orders', async () => {
    const response = await axios.get(
      'http://localhost:3000/v1/sales-order?page=1&limit=4',
      authorizedRequest,
    );

    expect(response).toBeDefined();
    expect(response.data).toBeDefined();
    expect(response.status).toBe(200);
  });
});
