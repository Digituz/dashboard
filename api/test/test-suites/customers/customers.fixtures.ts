import axios from 'axios';

import customersFixtures from './customer.fixtures.json';
import { getCredentials } from '../utils/credentials';

export async function insertCustomersFixtures() {
  const authorizedRequest = await getCredentials();

  const insertCustomerJobs = customersFixtures.map(customer => {
    return new Promise(async res => {
      await axios.post(
        'http://localhost:3005/v1/customers/',
        customer,
        authorizedRequest,
      );
      res();
    });
  });
  await Promise.all(insertCustomerJobs);
}
