import axios from 'axios';
import { getCredentials } from '../../utils/credentials';
import { insertProductFixtures } from '../../products/products-fixtures/products.fixture';
import { executeQueries, cleanUpDatabase } from '../../../test-suites/utils/queries';

import movingScenarios from './moving-inventory.scenarios.json';
import { InventoryMovementDTO } from 'src/inventory/inventory-movement.dto';

describe('moving inventory', () => {
  let authorizedRequest: any;

  beforeAll(async () => {
    authorizedRequest = await getCredentials();

    await cleanUpDatabase();

    await insertProductFixtures();

    await executeQueries(`
      insert into inventory (product_id, current_position, created_at, updated_at, version)
        select id, 0, now(), now(), 1 from product;
    `);
  });

  movingScenarios.forEach((movement: InventoryMovementDTO, idx: number) => {
    it(`should handle inventory movements properly (scenario #${idx})`, async () => {
      const response = await axios.post(
        'http://localhost:3000/v1/inventory/movement',
        movement,
        authorizedRequest,
      );

      expect(response).toBeDefined();
      expect(response.data).toBeDefined();
      expect(response.status).toBe(201);
      
      const movementCreated = response.data;
      expect(movementCreated.id).toBeDefined();
      expect(movementCreated.amount).toBe(movement.amount);
      expect(movementCreated.description).toBe(movement.description);
      expect(movementCreated.inventory.product.sku).toBe(movement.sku);
    });
  });
});
