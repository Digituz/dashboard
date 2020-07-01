import axios from 'axios';

import { bootstrap } from '../src/server';
import { INestApplication } from '@nestjs/common';

describe('AppController (e2e)', () => {
  let app: INestApplication;

  beforeAll(async done => {
    const silentMode = true;
    app = await bootstrap(silentMode);
    done();
  });

  afterAll(async done => {
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
