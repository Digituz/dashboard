import axios from 'axios';
import { getCredentials } from '../../utils/credentials';
import { insertProductFixtures } from '../../products/products-fixtures/products.fixture';
import {
  cleanUpDatabase,
  executeQuery,
} from '../../../test-suites/utils/queries';

import movingScenarios from './moving-inventory.scenarios.json';
import { InventoryMovementDTO } from '../../../../src/inventory/inventory-movement.dto';

describe('moving inventory', () => {
  let authorizedRequest: any;

  beforeAll(async () => {
    authorizedRequest = await getCredentials();

    await cleanUpDatabase();

    await insertProductFixtures();
  });

  movingScenarios.forEach((movement: InventoryMovementDTO, idx: number) => {
    it(`should handle inventory movements properly (scenario #${idx})`, async () => {
      const inventoryCurrentPositionQuery = `
        select i.current_position
        from inventory i
        left join product_variation p on p.id = i.product_variation_id
        where p.sku = '${movement.sku}'
      `;
      const productVariationCurrentPositionQuery = `
        select p.current_position
        from inventory i
        left join product_variation p on p.id = i.product_variation_id
        where p.sku = '${movement.sku}'
      `;
      const inventoryResultsBefore = await executeQuery(
        inventoryCurrentPositionQuery,
      );
      const productVariationResultsBefore = await executeQuery(
        productVariationCurrentPositionQuery,
      );
      const inventoryCurrentPositionBefore =
        inventoryResultsBefore[0].current_position;
      const productVariationCurrentPositionBefore =
        productVariationResultsBefore[0].current_position;

      const response = await axios.post(
        'http://localhost:3005/v1/inventory/movement',
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
      expect(movementCreated.inventory.productVariation.sku).toBe(movement.sku);

      const inventoryResultsAfter = await executeQuery(
        inventoryCurrentPositionQuery,
      );
      const inventoryCurrentPositionAfter =
        inventoryResultsAfter[0].current_position;

      const productVariationResultsAfter = await executeQuery(
        productVariationCurrentPositionQuery,
      );
      const productVariationCurrentPositionAfter =
        productVariationResultsAfter[0].current_position;

      expect(inventoryCurrentPositionAfter).toBe(
        inventoryCurrentPositionBefore + movement.amount,
      );
      expect(productVariationCurrentPositionAfter).toBe(
        productVariationCurrentPositionBefore + movement.amount,
      );
    });
  });
});
