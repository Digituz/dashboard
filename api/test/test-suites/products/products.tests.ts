import axios from 'axios';
import validFixtures from './valid-products.fixture.json';

describe('products', () => {
  let accessToken: string;

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

    expect(accessToken).toBeDefined();
  });

  it('to be able to create valid products', async done => {
    const postJobs = validFixtures.map(validFixture => {
      return new Promise(async res => {
        await axios.post('http://localhost:3000/v1/products', validFixture, {
          headers: {
            authorization: `Bearer ${accessToken}`,
          },
        });
        res();
      });
    });
    await Promise.all(postJobs);
    done();
  });
});
