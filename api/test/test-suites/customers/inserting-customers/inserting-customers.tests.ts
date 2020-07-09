import axios from 'axios';
import { getCredentials } from '../../utils/credentials';
import { cleanUpDatabase } from '../../../test-suites/utils/queries';

import insertingCustomersScenarios from './inserting-customers.scenarios.json';
import { Customer } from '../../../../src/customers/customer.entity';

describe('inserting customers', () => {
  let authorizedRequest: any;

  beforeAll(async () => {
    authorizedRequest = await getCredentials();

    await cleanUpDatabase();
  });

  insertingCustomersScenarios.forEach((customer: Customer, idx: number) => {
    it(`should insert new customers properly (scenario #${idx})`, async () => {
      const response = await axios.post(
        'http://localhost:3000/v1/customers/',
        customer,
        authorizedRequest,
      );

      expect(response).toBeDefined();
      expect(response.data).toBeDefined();
      expect(response.status).toBe(201);
      
      const customerCreated = response.data;
      expect(customerCreated.id).toBeDefined();
      expect(customerCreated.name).toBe(customer.name);
      expect(customerCreated.cpf).toBe(customer.cpf.replace(/\D/g,''));
      
      if (customer.birthday) {
        expect(customerCreated.birthday).toBe(customer.birthday);
      } else {
        expect(customerCreated.birthday).toBeNull();
      }
    });
  });
});
