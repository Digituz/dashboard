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
    await cleanUpDatabase();
    await app.close();
    done();
  });

  it('should be able to run tests', async () => {
    try {
      await axios.get('http://localhost:3000/');
      fail('an error should be thrown by the line above');
    } catch (err) {
      expect(err).toBeDefined();
    }
  });

  require('./test-suites/authentication.tests');
  require('./test-suites/products/products.tests');
  require('./test-suites/products/querying-products/querying-products.tests');
});
