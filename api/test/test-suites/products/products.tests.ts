import axios from 'axios';
import vFixtures from './valid-products.fixture.json';
import { ProductDTO } from '../../../src/products/dtos/product.dto';

const validFixtures: ProductDTO[] = vFixtures;

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

  validFixtures.forEach((validFixture: ProductDTO) => {
    it(`to be able to create valid products (${validFixture.sku})`, async done => {
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
        expect(response.data.productVariations?.length).toBe(
          validFixture.productVariations.length,
        );
      }

      if (validFixture.productImages) {
        expect(response.data.productImages?.length).toBe(
          validFixture.productImages.length,
        );
      }

      done();
    });
  });
});
