import axios from 'axios';
import persistedProducts from './querying-products.fixture.json';

import { executeQueries, cleanUpDatabase } from '../../utils/queries';
import { getCredentials } from '../../utils/credentials';

describe('querying products', () => {
  let authorizedRequest: any;

  beforeAll(async () => {
    await cleanUpDatabase();

    authorizedRequest = await getCredentials();

    await executeQueries(
      ...persistedProducts.map(
        p =>
          `insert into product (sku, title, ncm, variations_size, images_size)
           values ('${p.sku}', '${p.title}', '${p.ncm}', ${p.variations_size}, ${p.images_size});`,
      ),
    );
  });

  it('should sort results by title by default', async () => {
    const response = await axios.get(
      'http://localhost:3000/v1/products?page=1&limit=5',
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
    const response = await axios.get(
      'http://localhost:3000/v1/products?page=2&limit=5',
      authorizedRequest,
    );

    expect(response.data.items.length).toBe(4);
    expect(response.data.items[0].sku).toBe('A-05');
    expect(response.data.items[1].sku).toBe('A-06');
    expect(response.data.items[2].sku).toBe('A-07');
    expect(response.data.items[3].sku).toBe('A-08');
  });

  it('should sort by amount of product variations', async () => {
    let response = await axios.get(
      'http://localhost:3000/v1/products?page=1&limit=3&sortedBy=productVariations',
      authorizedRequest,
    );

    expect(response.data.items.length).toBe(3);
    expect(response.data.items[0].sku).toBe('A-00');
    expect(response.data.items[1].sku).toBe('A-01');
    expect(response.data.items[2].sku).toBe('A-02');

    response = await axios.get(
      'http://localhost:3000/v1/products?page=1&limit=3&sortedBy=productVariations&sortDirectionAscending=true',
      authorizedRequest,
    );

    expect(response.data.items.length).toBe(3);
    expect(response.data.items[0].sku).toBe('A-00');
    expect(response.data.items[1].sku).toBe('A-01');
    expect(response.data.items[2].sku).toBe('A-02');

    response = await axios.get(
      'http://localhost:3000/v1/products?page=1&limit=3&sortedBy=productVariations&sortDirectionAscending=false',
      authorizedRequest,
    );

    expect(response.data.items.length).toBe(3);
    expect(response.data.items[0].sku).toBe('A-08');
    expect(response.data.items[1].sku).toBe('A-07');
    expect(response.data.items[2].sku).toBe('A-06');
  });

  it('should sort by amount of product images', async () => {
    let response = await axios.get(
      'http://localhost:3000/v1/products?page=1&limit=3&sortedBy=productImages',
      authorizedRequest,
    );

    expect(response.data.items.length).toBe(3);
    expect(response.data.items[0].sku).toBe('A-00');
    expect(response.data.items[1].sku).toBe('A-01');
    expect(response.data.items[2].sku).toBe('A-02');

    response = await axios.get(
      'http://localhost:3000/v1/products?page=1&limit=3&sortedBy=productImages&sortDirectionAscending=true',
      authorizedRequest,
    );

    expect(response.data.items.length).toBe(3);
    expect(response.data.items[0].sku).toBe('A-00');
    expect(response.data.items[1].sku).toBe('A-01');
    expect(response.data.items[2].sku).toBe('A-02');

    response = await axios.get(
      'http://localhost:3000/v1/products?page=1&limit=3&sortedBy=productImages&sortDirectionAscending=false',
      authorizedRequest,
    );

    expect(response.data.items.length).toBe(3);
    expect(response.data.items[0].sku).toBe('A-08');
    expect(response.data.items[1].sku).toBe('A-07');
    expect(response.data.items[2].sku).toBe('A-06');
  });
});
