import axios from 'axios';
import { getCredentials } from '../../utils/credentials';
import {
  cleanUpDatabase,
  executeQuery,
} from '../../../test-suites/utils/queries';

import { insertCustomersFixtures } from '../customers.fixtures';

describe('querying customers', () => {
  let authorizedRequest: any;

  beforeAll(async () => {
    authorizedRequest = await getCredentials();

    await cleanUpDatabase();

    await insertCustomersFixtures();
  });

  it('should be able to query customers', async () => {
    const response = await axios.get(
      'http://localhost:3005/v1/customers?page=1&limit=4',
      authorizedRequest,
    );

    expect(response).toBeDefined();
    expect(response.data).toBeDefined();
    expect(response.status).toBe(200);

    const result = response.data;
    expect(result.items.length).toBe(4);
    expect(result.items[0].name).toBe('Bruno Krebs');
    expect(result.items[1].name).toBe('Jose da Silva');
    expect(result.items[2].name).toBe('Maria da Silva');
    expect(result.items[3].name).toBe('Maria da Silva');

    const responsePage2 = await axios.get(
      'http://localhost:3005/v1/customers?page=2&limit=4',
      authorizedRequest,
    );

    expect(responsePage2).toBeDefined();
    expect(responsePage2.data).toBeDefined();
    expect(responsePage2.status).toBe(200);

    const resultPage2 = responsePage2.data;
    expect(resultPage2.items.length).toBe(2);
    expect(resultPage2.items[0].name).toBe('Minhoca Krebs');
    expect(resultPage2.items[1].name).toBe('Pingo Krebs');
  });

  it('should be able to query customers while filtering by name', async () => {
    const response = await axios.get(
      'http://localhost:3005/v1/customers?page=1&limit=4&query=krebs',
      authorizedRequest,
    );

    expect(response).toBeDefined();
    expect(response.data).toBeDefined();
    expect(response.status).toBe(200);

    const result = response.data;
    expect(result.items.length).toBe(3);
    expect(result.items[0].name).toBe('Bruno Krebs');
    expect(result.items[1].name).toBe('Minhoca Krebs');
    expect(result.items[2].name).toBe('Pingo Krebs');
  });
});
