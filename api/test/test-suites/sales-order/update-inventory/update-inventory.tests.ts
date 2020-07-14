import axios from 'axios';
import { getCredentials } from '../../utils/credentials';
import { cleanUpDatabase, executeQuery } from '../../utils/queries';
import { insertProductFixtures } from '../../products/products-fixtures/products.fixture';
import saleOrderScenarios from '../sales-order.scenarios.json';
import { SaleOrderDTO } from '../../../../src/sales-order/sale-order.dto';

interface ItemPosition {
  sku: string;
  position: number;
}

describe('sale orders must update inventory', () => {
  let authorizedRequest: any;

  beforeAll(async () => {
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
      saleOrder: response.data,
      positions: initialPositions,
    };
  }

  it('should subtract from inventory on creation', async () => {
    const saleOrderDTO: SaleOrderDTO = saleOrderScenarios[0];

    const { positions: initialPositions } = await persistSaleOrder(
      saleOrderDTO,
    );

    // get position after creating the sale order
    const positionsAfterCreating = await getCurrentPositions(
      saleOrderDTO.items,
    );

    for (const positionAfterCreating of positionsAfterCreating) {
      // validate that the position was properly update
      const initialPosition = initialPositions.find(
        position => position.sku === positionAfterCreating.sku,
      );
      const item = saleOrderDTO.items.find(
        item => item.sku === positionAfterCreating.sku,
      );
      expect(positionAfterCreating.position).toBe(
        initialPosition.position - item.amount,
      );
    }
  });

  // it('should amend inventory on update', async () => {
  //   const saleOrderDTO: SaleOrderDTO = saleOrderScenarios[0];

  //   const { saleOrder, initialPosition } = await persistSaleOrder(saleOrderDTO);

  //   // make some random change on the sale order
  //   const updateResponse = await axios.post(
  //     `http://localhost:3000/v1/sales-order/`,
  //     {
  //       ...saleOrder,
  //       id: saleOrder.id,
  //       customerName: 'John Doe',
  //     },
  //     authorizedRequest,
  //   );

  //   expect(updateResponse).toBeDefined();
  //   expect(updateResponse.data).toBeDefined();
  //   expect(updateResponse.status).toBe(201);

  //   // get position after updating the sale order
  //   const positionAfterUpdate = await getCurrentPosition(
  //     saleOrder.items[0].sku,
  //   );

  //   // validate that the position was not changed
  //   expect(positionAfterUpdate).toBe(positionAfterCreate);

  //   // change the sale order status
  //   await changeOrderStatus(saleOrderReference, 'APPROVED');

  //   // get position after changing the status
  //   const positionAfterStatusUpdate = await getCurrentPosition(
  //     saleOrder.items[0].sku,
  //   );

  //   // validate that the position was not changed
  //   expect(positionAfterStatusUpdate).toBe(positionAfterCreate);

  //   // cancel the sale order
  //   await changeOrderStatus(saleOrderReference, 'CANCELLED');

  //   // get position after changing the status
  //   const positionAfterCancelling = await getCurrentPosition(
  //     saleOrder.items[0].sku,
  //   );

  //   // validate that the position was not changed
  //   expect(positionAfterCancelling).toBe(initialPosition);
  // });
});
