import axios from 'axios';
import { isEqual, differenceWith } from 'lodash';
import { getCredentials } from '../../utils/credentials';
import { cleanUpDatabase, executeQuery } from '../../utils/queries';
import { insertProductFixtures } from '../../products/products-fixtures/products.fixture';
import saleOrderScenarios from '../sales-order.scenarios.json';
import { SaleOrderDTO } from '../../../../src/sales-order/sale-order.dto';
import { SaleOrder } from '../../../../src/sales-order/entities/sale-order.entity';
import { assert } from 'console';

interface ItemPosition {
  sku: string;
  position: number;
}

describe('sale orders must update inventory', () => {
  let authorizedRequest: any;

  beforeEach(async () => {
    authorizedRequest = await getCredentials();

    await cleanUpDatabase();

    await insertProductFixtures();
  });

  async function changeOrderStatus(reference, status) {
    const response = await axios.post(
      `http://localhost:3000/v1/sales-order/${reference}`,
      { status },
      authorizedRequest,
    );

    expect(response).toBeDefined();
    expect(response.data).toBeDefined();
    expect(response.status).toBe(201);
  }

  async function getSumOfMovements(orderId: number) {
    const movementTotalRes = await executeQuery(
      `select sum(amount) as amount
        from inventory_movement
        where sale_order_id = ${orderId};`,
    );
    return parseInt(movementTotalRes[0].amount);
  }

  async function getCurrentPosition(sku: String): Promise<number> {
    const currrentPositionRows = await executeQuery(
      `select current_position
        from inventory i
        left join product p on i.product_id = p.id
        where p.sku = '${sku}';`,
    );
    return parseInt(currrentPositionRows[0].current_position);
  }

  async function getCurrentPositions(items): Promise<ItemPosition[]> {
    const getPositionJobs = items.map(item => {
      return new Promise(async res => {
        const initialPosition = await getCurrentPosition(item.sku);
        res({
          sku: item.sku,
          position: initialPosition,
        });
      });
    });
    return Promise.all(getPositionJobs);
  }

  async function persistSaleOrder(saleOrder: SaleOrderDTO) {
    // get position before creating the sale order
    const initialPositions = await getCurrentPositions(saleOrder.items);

    // create the sale order
    const response = await axios.post(
      `http://localhost:3000/v1/sales-order/`,
      saleOrder,
      authorizedRequest,
    );

    expect(response).toBeDefined();
    expect(response.data).toBeDefined();
    expect(response.status).toBe(201);

    return {
      saleOrder: response.data as SaleOrder,
      positions: initialPositions,
    };
  }

  function checkInventoryMovements(items, previousPositions, currentPositions) {
    for (const currentPosition of currentPositions) {
      // validate that the position was properly update
      const previousPosition = previousPositions.find(
        position => position.sku === currentPosition.sku,
      );
      const item = items.find(item => item.sku === currentPosition.sku);
      expect(currentPosition.position).toBe(
        previousPosition.position - item.amount,
      );
    }
  }

  function checkEqual(previousPositions, currentPositions) {
    return (
      differenceWith(previousPositions, currentPositions, isEqual).length === 0
    );
  }

  it('should subtract from inventory on creation', async () => {
    const saleOrderDTO: SaleOrderDTO = saleOrderScenarios[0];

    const { positions: initialPositions, saleOrder } = await persistSaleOrder(
      saleOrderDTO,
    );

    // get position after creating the sale order
    const positionsAfterCreating = await getCurrentPositions(
      saleOrderDTO.items,
    );

    checkInventoryMovements(
      saleOrderDTO.items,
      initialPositions,
      positionsAfterCreating,
    );

    const sumOfMovements = await getSumOfMovements(saleOrder.id);
    expect(sumOfMovements).toBe(
      saleOrderDTO.items.reduce((total, item) => total - item.amount, 0),
    );
  });

  it('should not change positions when items remain the same', async () => {
    const saleOrderDTO: SaleOrderDTO = saleOrderScenarios[0];

    const { positions: initialPositions, saleOrder } = await persistSaleOrder(
      saleOrderDTO,
    );

    const { positions: positionBeforeUpdate } = await persistSaleOrder({
      ...saleOrderDTO,
      id: saleOrder.id,
      customerName: 'John Doe',
    });

    checkInventoryMovements(
      saleOrderDTO.items,
      initialPositions,
      positionBeforeUpdate,
    );
  });

  it('should amend inventory when items change', async () => {
    const saleOrderDTO: SaleOrderDTO = saleOrderScenarios[0];

    const { saleOrder } = await persistSaleOrder(saleOrderDTO);

    const newItems = [
      {
        sku: 'A-01',
        price: 10,
        discount: 0,
        amount: 1,
      },
      {
        sku: 'A-03',
        price: 30,
        discount: 0,
        amount: 3,
      },
      {
        sku: 'A-05',
        price: 50,
        discount: 0,
        amount: 7,
      },
    ];

    const { positions: previousPositions } = await persistSaleOrder({
      ...saleOrderDTO,
      id: saleOrder.id,
      customerName: 'John Doe',
      items: newItems,
    });

    const positionsAfterUpdate = await getCurrentPositions(newItems);

    checkInventoryMovements(newItems, previousPositions, positionsAfterUpdate);
  });

  it('should not change inventory when payment status change to APPROVED', async () => {
    const order: SaleOrderDTO = saleOrderScenarios[0];

    const { saleOrder } = await persistSaleOrder(order);

    const positionsAfterCreation = await getCurrentPositions(order.items);

    await changeOrderStatus(saleOrder.referenceCode, 'APPROVED');

    const positionsAfterUpdate = await getCurrentPositions(order.items);

    expect(checkEqual(positionsAfterCreation, positionsAfterUpdate)).toBe(true);
  });

  it('should revert movements when payment status change to CANCELLED', async () => {
    const order: SaleOrderDTO = saleOrderScenarios[1];

    const { saleOrder, positions: initialPositions } = await persistSaleOrder(
      order,
    );

    await changeOrderStatus(saleOrder.referenceCode, 'CANCELLED');

    const positionsAfterUpdate = await getCurrentPositions(order.items);

    expect(checkEqual(initialPositions, positionsAfterUpdate)).toBe(true);
  });

  it('should not accept changes to status after being CANCELLED', async () => {
    const order: SaleOrderDTO = saleOrderScenarios[1];

    const { saleOrder, positions: initialPositions } = await persistSaleOrder(
      order,
    );

    await changeOrderStatus(saleOrder.referenceCode, 'CANCELLED');

    try {
      await changeOrderStatus(saleOrder.referenceCode, 'APPROVED');
      fail('should have raised an error');
    } catch (err) {}
  });
});
