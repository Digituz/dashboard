import axios from 'axios';

import { cleanUpDatabase } from '../../utils/queries';
import { getCredentials } from '../../utils/credentials';
import { insertProductFixtures } from '../products-fixtures/products.fixture';
import productsFixtures from '../products-fixtures/products.fixtures.json';

describe('querying products', () => {
  let authorizedRequest: any;

  beforeAll(async () => {
    await cleanUpDatabase();

    authorizedRequest = await getCredentials();

    await insertProductFixtures();
  });

  it('should be able to retrieve all products with variations, images, and inventory', async () => {
    const response = await axios.get(
      'http://localhost:3005/v1/products/all',
      authorizedRequest,
    );
    expect(response.data.length).toBe(productsFixtures.length);
    for (const product of response.data) {
      expect(product.productVariations).toBeDefined();

      const { sku } = product;
      const productFixture = productsFixtures.find(p => p.sku === sku);

      if (productFixture.productVariations) {
        expect(product.productVariations.length).toBe(
          productFixture.productVariations.length,
        );
      } else {
        expect(product.productVariations.length).toBe(1);
      }

      for (const variation of product.productVariations) {
        expect(variation.currentPosition).toBeDefined();
      }
    }
  });

  it('should sort results by title by default', async () => {
    const response = await axios.get(
      'http://localhost:3005/v1/products?page=1&limit=5',
      authorizedRequest,
    );

    expect(response.data.items.length).toBe(5);
    expect(response.data.items[0].sku).toBe('A-00');
    expect(response.data.items[1].sku).toBe('A-01');
    expect(response.data.items[2].sku).toBe('A-02');
    expect(response.data.items[3].sku).toBe('A-03');
    expect(response.data.items[4].sku).toBe('A-04');
  });

  it('should paginate properly', async () => {
    const limit = 5;
    const response = await axios.get(
      `http://localhost:3005/v1/products?page=2&limit=${limit}`,
      authorizedRequest,
    );

    expect(response.data.items.length).toBe(productsFixtures.length - limit);
    expect(response.data.items[0].sku).toBe('A-05');
    expect(response.data.items[1].sku).toBe('A-06');
    expect(response.data.items[2].sku).toBe('A-07');
    expect(response.data.items[3].sku).toBe('A-08');
  });

  it('should sort by amount of product variations', async () => {
    let response = await axios.get(
      'http://localhost:3005/v1/products?page=1&limit=3&sortedBy=productVariations',
      authorizedRequest,
    );

    expect(response.data.items.length).toBe(3);
    expect(response.data.items[0].sku).toBe('A-00');
    expect(response.data.items[1].sku).toBe('A-01');
    expect(response.data.items[2].sku).toBe('A-02');

    response = await axios.get(
      'http://localhost:3005/v1/products?page=1&limit=3&sortedBy=productVariations&sortDirectionAscending=true',
      authorizedRequest,
    );

    expect(response.data.items.length).toBe(3);
    expect(response.data.items[0].sku).toBe('A-00');
    expect(response.data.items[1].sku).toBe('A-01');
    expect(response.data.items[2].sku).toBe('A-02');

    response = await axios.get(
      'http://localhost:3005/v1/products?page=1&limit=3&sortedBy=productVariations&sortDirectionAscending=false',
      authorizedRequest,
    );

    expect(response.data.items.length).toBe(3);
    expect(response.data.items[0].sku).toBe('A-09');
    expect(response.data.items[1].sku).toBe('A-08');
    expect(response.data.items[2].sku).toBe('A-07');
  });

  it('should sort by amount of product images', async () => {
    let response = await axios.get(
      'http://localhost:3005/v1/products?page=1&limit=3&sortedBy=productImages',
      authorizedRequest,
    );

    expect(response.data.items.length).toBe(3);
    expect(response.data.items[0].sku).toBe('A-00');
    expect(response.data.items[1].sku).toBe('A-01');
    expect(response.data.items[2].sku).toBe('A-02');

    response = await axios.get(
      'http://localhost:3005/v1/products?page=1&limit=3&sortedBy=productImages&sortDirectionAscending=true',
      authorizedRequest,
    );

    expect(response.data.items.length).toBe(3);
    expect(response.data.items[0].sku).toBe('A-00');
    expect(response.data.items[1].sku).toBe('A-01');
    expect(response.data.items[2].sku).toBe('A-02');

    response = await axios.get(
      'http://localhost:3005/v1/products?page=1&limit=3&sortedBy=productImages&sortDirectionAscending=false',
      authorizedRequest,
    );

    expect(response.data.items.length).toBe(3);
    expect(response.data.items[0].sku).toBe('A-09');
    expect(response.data.items[1].sku).toBe('A-08');
    expect(response.data.items[2].sku).toBe('A-07');
  });
});
