import axios from 'axios';

import { insertProductFixtures } from '../products/products-fixtures/products.fixture';
import productsFixtures from '../products/products-fixtures/products.fixtures.json';
import { getCredentials } from '../utils/credentials';
import { InventoryMovementDTO } from '../../../src/inventory/inventory-movement.dto';

export async function insertInventoryFixtures() {
  const authorizedRequest = await getCredentials();

  await insertProductFixtures();

  const productVariations = [];
  for (const product of productsFixtures) {
    if (!product.productVariations) return;
    productVariations.push(...product.productVariations);
  }

  const moveInventoryJobs = productVariations.map((p, index) => {
    return new Promise(async res => {
      const movement: InventoryMovementDTO = {
        sku: p.sku,
        amount: index,
        description: `Random movement for fixture #${index}`,
      };
      await axios.post(
        'http://localhost:3005/v1/inventory/movement',
        movement,
        authorizedRequest,
      );
      res();
    });
  });
  await Promise.all(moveInventoryJobs);
}
