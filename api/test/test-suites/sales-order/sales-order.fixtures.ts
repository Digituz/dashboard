import saleOrderScenarios from './sales-order.scenarios.json';
import axios from 'axios';
import { getCredentials } from '../utils/credentials';
import { SaleOrderDTO } from '../../../src/sales-order/sale-order.dto';

export async function createSaleOrders(): Promise<unknown> {
  const authorizedRequest = await getCredentials();
  const insertJobs = saleOrderScenarios.map(
    (saleOrder: SaleOrderDTO, idx: number) => {
      return new Promise(res => {
        setTimeout(async () => {
          await axios.post(
            'http://localhost:3005/v1/sales-order',
            saleOrder,
            authorizedRequest,
          );
          res();
        }, idx * 100);
        // TODO remove setTimeout: without it the api uses the same transaction
        // to persist objects. which end up causing problems
        // (probably) related to: https://github.com/Digituz/dashboard/issues/10
      });
    },
  );
  return Promise.all(insertJobs);
}
