import axios from 'axios';
import validFixtures from './valid-products.fixture.json';

describe('products', () => {
  let accessToken: string;
  let authorizedRequest: any;

  beforeAll(async () => {
    const validCrendetials = {
      username: 'bruno.krebs@fridakahlo.com.br',
      password: 'lbX01as$',
    };

    const resp = await axios.post(
      'http://localhost:3000/v1/sign-in',
      validCrendetials,
    );
    accessToken = resp.data.access_token;

    authorizedRequest = {
      headers: {
        authorization: `Bearer ${accessToken}`,
      },
    };

    expect(accessToken).toBeDefined();
  });

  it('to be able to create valid products', async done => {
    const postJobs = validFixtures.map((validFixture, idx) => {
      return new Promise(async res => {
        setTimeout(async () => {
          await axios.post(
            'http://localhost:3000/v1/products',
            validFixture,
            authorizedRequest,
          );

          const response = await axios.get(
            `http://localhost:3000/v1/products/${validFixture.sku}`,
            authorizedRequest,
          );

          expect(response.data.sku).toBe(validFixture.sku);
          if (validFixture.productVariations) {
            expect(response.data.productVariations.length).toBe(
              validFixture.productVariations.length,
            );
          }

          res();
        }, idx * 250);
      });
    });
    await Promise.all(postJobs);
    done();
  });
});
