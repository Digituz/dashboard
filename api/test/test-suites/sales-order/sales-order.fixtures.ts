import saleOrderScenarios from './sales-order.scenarios.json';
import axios from 'axios';
import { getCredentials } from '../utils/credentials';
import { SaleOrderDTO } from 'src/sales-order/sale-order.dto';

export async function createSaleOrders(): Promise<unknown> {
  const authorizedRequest = await getCredentials();
  const insertJobs = saleOrderScenarios.map((saleOrder: SaleOrderDTO) => {
    return new Promise(async res => {
      await axios.post(
        'http://localhost:3000/v1/sales-order',
        saleOrder,
        authorizedRequest,
      );
      res();
    });
  });
  return Promise.all(insertJobs);
}
