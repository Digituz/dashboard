import axios from 'axios';
import { getCredentials } from '../../utils/credentials';
import { cleanUpDatabase, executeQuery } from '../../utils/queries';
import { insertProductFixtures } from '../../products/products-fixtures/products.fixture';
import saleOrderScenarios from '../sales-order.scenarios.json';
import { SaleOrderDTO } from '../../../../src/sales-order/sale-order.dto';

describe('update inventory when sale order is created or updated', () => {
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

  async function getCurrentPosition(sku: String) {
    const currrentPositionRows = await executeQuery(
      `select current_position
        from inventory i
        left join product p on i.product_id = p.id
        where p.sku = '${sku}';`,
    );
    return parseInt(currrentPositionRows[0].current_position);
  }

  it.only('should update sale order payment status', async () => {
    const saleOrder: SaleOrderDTO = saleOrderScenarios[0];

    // get position before creating the sale order
    const initialPosition = await getCurrentPosition(saleOrder.items[0].sku);

    // create the sale order
    const response = await axios.post(
      `http://localhost:3000/v1/sales-order/`,
      saleOrder,
      authorizedRequest,
    );

    expect(response).toBeDefined();
    expect(response.data).toBeDefined();
    expect(response.status).toBe(201);

    const saleOrderReference = response.data.referenceCode;

    // get position after creating the sale order
    const positionAfterCreate = await getCurrentPosition(saleOrder.items[0].sku);

    // validate that the position was properly update
    expect(positionAfterCreate).toBe(initialPosition - saleOrder.items[0].amount)

    // make some random change on the sale order
    const updateResponse = await axios.post(
      `http://localhost:3000/v1/sales-order/`,
      {
        ...saleOrder,
        id: response.data.id,
        customerName: 'John Doe'
      },
      authorizedRequest,
    );

    expect(updateResponse).toBeDefined();
    expect(updateResponse.data).toBeDefined();
    expect(updateResponse.status).toBe(201);
    
    // get position after updating the sale order
    const positionAfterUpdate = await getCurrentPosition(saleOrder.items[0].sku);

    // validate that the position was not changed
    expect(positionAfterUpdate).toBe(positionAfterCreate);

    // change the sale order status
    await changeOrderStatus(saleOrderReference, 'APPROVED');

    // get position after changing the satus
    const positionAfterStatusUpdate = await getCurrentPosition(saleOrder.items[0].sku);

    // validate that the position was not changed
    expect(positionAfterStatusUpdate).toBe(positionAfterCreate);

    // cancel the sale order
    await changeOrderStatus(saleOrderReference, 'CANCELLED');

    // get position after changing the satus
    const positionAfterCancelling = await getCurrentPosition(saleOrder.items[0].sku);

    // validate that the position was not changed
    expect(positionAfterCancelling).toBe(positionAfterCreate);
  });
});
