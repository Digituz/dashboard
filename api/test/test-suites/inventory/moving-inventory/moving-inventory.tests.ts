import axios from 'axios';
import { getCredentials } from '../../utils/credentials';
import { insertProductFixtures } from '../../products/products-fixtures/products.fixture';
import { executeQueries, cleanUpDatabase, executeQuery } from '../../../test-suites/utils/queries';

import movingScenarios from './moving-inventory.scenarios.json';
import { InventoryMovementDTO } from 'src/inventory/inventory-movement.dto';

describe('moving inventory', () => {
  let authorizedRequest: any;

  beforeAll(async () => {
    authorizedRequest = await getCredentials();

    await cleanUpDatabase();

    await insertProductFixtures();
  });

  movingScenarios.forEach((movement: InventoryMovementDTO, idx: number) => {
    it(`should handle inventory movements properly (scenario #${idx})`, async () => {
      const currentPositionQuery = `
        select current_position
        from inventory i
        left join product p on p.id = i.product_id
        where p.sku = '${movement.sku}'
      `;
      const resultsBefore = await executeQuery(currentPositionQuery);
      const currentPositionBefore = resultsBefore[0].current_position;

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

      const resultsAfter = await executeQuery(currentPositionQuery);
      const currentPositionAfter = resultsAfter[0].current_position;

      expect(currentPositionAfter).toBe(currentPositionBefore + movement.amount);
    });
  });
});
