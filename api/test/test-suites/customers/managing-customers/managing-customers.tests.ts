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
        'http://localhost:3005/v1/customers/',
        customer,
        authorizedRequest,
      );

      expect(response).toBeDefined();
      expect(response.data).toBeDefined();
      expect(response.status).toBe(201);

      const customerCreated = response.data;
      expect(customerCreated.id).toBeDefined();
      expect(customerCreated.name).toBe(customer.name);
      expect(customerCreated.cpf).toBe(customer.cpf.replace(/\D/g, ''));

      if (customer.birthday) {
        expect(customerCreated.birthday).toBe(customer.birthday);
      } else {
        expect(customerCreated.birthday).toBeNull();
      }
    });
  });

  it('should be able to update customers', async () => {
    const customer: Customer = {
      cpf: '444.444.444-44',
      name: 'Some Other Customer',
    };

    const response = await axios.post(
      'http://localhost:3005/v1/customers/',
      customer,
      authorizedRequest,
    );

    expect(response).toBeDefined();
    expect(response.data).toBeDefined();
    expect(response.data.id).toBeDefined();
    expect(response.status).toBe(201);

    const customerId = response.data.id;

    const updateResponse = await axios.put(
      `http://localhost:3005/v1/customers/${customerId}`,
      customer,
      authorizedRequest,
    );

    expect(updateResponse).toBeDefined();
    expect(updateResponse.data).toBeDefined();
    expect(updateResponse.status).toBe(200);

    customer.phoneNumber = '(51) 98765-4321';
    const secondUpdateResponse = await axios.put(
      `http://localhost:3005/v1/customers/${customerId}`,
      customer,
      authorizedRequest,
    );

    expect(secondUpdateResponse).toBeDefined();
    expect(secondUpdateResponse.data).toBeDefined();
    expect(secondUpdateResponse.status).toBe(200);
  });
});
