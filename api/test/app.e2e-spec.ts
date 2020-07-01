import axios from 'axios';
import { Client } from 'pg';
import { config } from 'dotenv';

// making sure we load env vars before any custom code
config({ path: `${__dirname}/.env` })

import { bootstrap } from '../src/server';
import { INestApplication } from '@nestjs/common';

describe('AppController (e2e)', () => {
  let app: INestApplication;

  beforeAll(async done => {
    const silentMode = true;
    process.env.PGUSER=process.env.DATABASE_USER;
    process.env.PGHOST=process.env.DATABASE_HOST;
    process.env.PGPASSWORD=process.env.DATABASE_PASSWORD;
    process.env.PGDATABASE=process.env.DATABASE_NAME;
    app = await bootstrap(silentMode);
    done();
  });

  afterAll(async done => {
    const client = new Client();
    await client.connect();
    await client.query('delete from tag;');
    await client.query('delete from product_image;');
    await client.query('delete from product_variation;');
    await client.query('delete from product;');
    await client.end();

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
});
