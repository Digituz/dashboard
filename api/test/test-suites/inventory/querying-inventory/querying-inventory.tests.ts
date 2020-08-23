import axios from 'axios';
import { getCredentials } from '../../utils/credentials';
import { cleanUpDatabase } from '../../../test-suites/utils/queries';

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
      'http://localhost:3005/v1/inventory?page=1&limit=3',
      authorizedRequest,
    );

    expect(response).toBeDefined();
    expect(response.data).toBeDefined();
    expect(response.status).toBe(200);

    const result = response.data;
    expect(result.items.length).toBe(3);
    expect(result.items[0].productVariationDetails.sku).toBe('A-00');
    expect(result.items[1].productVariationDetails.sku).toBe('A-01-15');
    expect(result.items[2].productVariationDetails.sku).toBe('A-02-15');

    const responsePage2 = await axios.get(
      'http://localhost:3005/v1/inventory?page=2&limit=3',
      authorizedRequest,
    );

    expect(responsePage2).toBeDefined();
    expect(responsePage2.data).toBeDefined();
    expect(responsePage2.status).toBe(200);

    const resultPage2 = responsePage2.data;
    expect(resultPage2.items.length).toBe(3);
    expect(resultPage2.items[0].productVariationDetails.sku).toBe('A-02-16');
    expect(resultPage2.items[1].productVariationDetails.sku).toBe('A-03-15');
    expect(resultPage2.items[2].productVariationDetails.sku).toBe('A-03-16');
  });

  it('should be able to query inventory sorting results', async () => {
    const response = await axios.get(
      'http://localhost:3005/v1/inventory?page=1&limit=3&order=currentPosition&sortDirectionAscending=false',
      authorizedRequest,
    );

    expect(response).toBeDefined();
    expect(response.data).toBeDefined();
    expect(response.status).toBe(200);

    const result = response.data;
    expect(result.items.length).toBe(3);
    expect(result.items[0].productVariationDetails.sku).toBe('A-09-23');
    expect(result.items[1].productVariationDetails.sku).toBe('A-09-22');
    expect(result.items[2].productVariationDetails.sku).toBe('A-09-21');

    const responsePage2 = await axios.get(
      'http://localhost:3005/v1/inventory?page=2&limit=3&order=currentPosition&sortDirectionAscending=false',
      authorizedRequest,
    );

    expect(responsePage2).toBeDefined();
    expect(responsePage2.data).toBeDefined();
    expect(responsePage2.status).toBe(200);

    const resultPage2 = responsePage2.data;
    expect(resultPage2.items.length).toBe(3);
    expect(resultPage2.items[0].productVariationDetails.sku).toBe('A-09-20');
    expect(resultPage2.items[1].productVariationDetails.sku).toBe('A-09-19');
    expect(resultPage2.items[2].productVariationDetails.sku).toBe('A-09-18');
  });

  it('should be able to query inventory sorting and querying results', async () => {
    const response = await axios.get(
      'http://localhost:3005/v1/inventory?page=1&limit=3&order=currentPosition&sortDirectionAscending=false&query=A-01',
      authorizedRequest,
    );

    expect(response).toBeDefined();
    expect(response.data).toBeDefined();
    expect(response.status).toBe(200);

    const result = response.data;
    expect(result.items.length).toBe(1);
    expect(result.items[0].productVariationDetails.sku).toBe('A-01-15');
  });
});
