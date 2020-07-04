import products from './products.fixtures.json';

import { executeQueries } from '../../utils/queries';

export async function insertFixtures() {
  await executeQueries(
    ...products.map(
      p =>
        `insert into product (sku, title, ncm, variations_size, images_size)
             values ('${p.sku}', '${p.title}', '${p.ncm}', ${p.variations_size}, ${p.images_size});`,
    ),
  );
}

export async function cleanUpFixtures() {
  const skus = products.map(p => `'${p.sku}'`).join(', ');
  await executeQueries(
    ...products.map(p => `delete from product where sku in values (${skus});`),
  );
}
