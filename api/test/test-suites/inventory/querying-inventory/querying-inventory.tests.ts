import axios from 'axios';
import { getCredentials } from '../../utils/credentials';
import {
  cleanUpDatabase,
  executeQuery,
} from '../../../test-suites/utils/queries';

import { insertInventoryFixtures } from '../inventory-fixtures.fixtures';

describe('querying inventory', () => {
  let authorizedRequest: any;

  beforeAll(async () => {
    authorizedRequest = await getCredentials();

    await cleanUpDatabase();

    await insertInventoryFixtures();
  });

  it('should be able to query inventory', async () => {
    const response = await axios.get(
      'http://localhost:3000/v1/inventory?page=1&limit=3',
      authorizedRequest,
    );

    expect(response).toBeDefined();
    expect(response.data).toBeDefined();
    expect(response.status).toBe(200);

    const result = response.data;
    expect(result.items.length).toBe(3);
    expect(result.items[0].product.sku).toBe('A-00');
    expect(result.items[1].product.sku).toBe('A-01');
    expect(result.items[2].product.sku).toBe('A-02');

    const responsePage2 = await axios.get(
      'http://localhost:3000/v1/inventory?page=2&limit=3',
      authorizedRequest,
    );

    expect(responsePage2).toBeDefined();
    expect(responsePage2.data).toBeDefined();
    expect(responsePage2.status).toBe(200);

    const resultPage2 = responsePage2.data;
    expect(resultPage2.items.length).toBe(3);
    expect(resultPage2.items[0].product.sku).toBe('A-03');
    expect(resultPage2.items[1].product.sku).toBe('A-04');
    expect(resultPage2.items[2].product.sku).toBe('A-05');
  });

  it('should be able to query inventory sorting results', async () => {
    const response = await axios.get(
      'http://localhost:3000/v1/inventory?page=1&limit=3&order=currentPosition&sortDirectionAscending=false',
      authorizedRequest,
    );

    expect(response).toBeDefined();
    expect(response.data).toBeDefined();
    expect(response.status).toBe(200);

    const result = response.data;
    expect(result.items.length).toBe(3);
    expect(result.items[0].product.sku).toBe('A-08');
    expect(result.items[1].product.sku).toBe('A-07');
    expect(result.items[2].product.sku).toBe('A-06');

    const responsePage2 = await axios.get(
      'http://localhost:3000/v1/inventory?page=2&limit=3&order=currentPosition&sortDirectionAscending=false',
      authorizedRequest,
    );

    expect(responsePage2).toBeDefined();
    expect(responsePage2.data).toBeDefined();
    expect(responsePage2.status).toBe(200);

    const resultPage2 = responsePage2.data;
    expect(resultPage2.items.length).toBe(3);
    expect(resultPage2.items[0].product.sku).toBe('A-05');
    expect(resultPage2.items[1].product.sku).toBe('A-04');
    expect(resultPage2.items[2].product.sku).toBe('A-03');
  });

  it('should be able to query inventory sorting and querying results', async () => {
    const response = await axios.get(
      'http://localhost:3000/v1/inventory?page=1&limit=3&order=currentPosition&sortDirectionAscending=false&query=A-01',
      authorizedRequest,
    );

    expect(response).toBeDefined();
    expect(response.data).toBeDefined();
    expect(response.status).toBe(200);

    const result = response.data;
    expect(result.items.length).toBe(1);
    expect(result.items[0].product.sku).toBe('A-01');
  });
});
