import axios from 'axios';
import { config } from 'dotenv';

// making sure we load env vars before any custom code
config({ path: `${__dirname}/.env` });

import { bootstrap } from '../src/server';
import { INestApplication } from '@nestjs/common';
import { cleanUpDatabase } from './test-suites/utils/queries';

describe('AppController (e2e)', () => {
  let app: INestApplication;

  beforeAll(async done => {
    const silentMode = true;
    process.env.PGUSER = process.env.DATABASE_USER;
    process.env.PGHOST = process.env.DATABASE_HOST;
    process.env.PGPASSWORD = process.env.DATABASE_PASSWORD;
    process.env.PGDATABASE = process.env.DATABASE_NAME;

    await cleanUpDatabase();

    app = await bootstrap(silentMode);
    done();
  });

  afterAll(async done => {
    await app.close();
    done();
  });

  it('should be able to run tests', async () => {
    try {
      await axios.get('http://localhost:3005/');
      fail('an error should be thrown by the line above');
    } catch (err) {
      expect(err).toBeDefined();
    }
  });

  require('./test-suites/authentication.tests');
  require('./test-suites/bling/managing-orders.tests');
  require('./test-suites/products/products.tests');
  require('./test-suites/products/querying-products/querying-products.tests');
  require('./test-suites/products/composite-products/composite-products.tests');
  require('./test-suites/customers/managing-customers/managing-customers.tests');
  require('./test-suites/customers/querying-customers/querying-customers.tests');
  require('./test-suites/inventory/moving-inventory/moving-inventory.tests');
  require('./test-suites/inventory/querying-inventory/querying-inventory.tests');
  require('./test-suites/sales-order/persist-sale-order/persist-sale-order.tests');
  require('./test-suites/sales-order/querying-sale-orders/querying-sale-orders.tests');
  require('./test-suites/sales-order/update-payment-status/update-payment-status.tests');
  require('./test-suites/sales-order/update-inventory/update-inventory.tests');
});
