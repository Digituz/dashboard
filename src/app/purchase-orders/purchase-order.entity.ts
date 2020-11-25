import { Supplier } from '@app/supplier/supplier.entity';
import { PurchaseOrderItem } from './purchase-order-item.entity';
import { PurchaseOrderStatus } from './purchase-orders.enum';

export interface PurchaseOrder {
  referenceCode?: number;
  creationDate?: string;
  completionDate?: string;
  discount?: Number;
  shippingPrice?: Number;
  total?: Number;
  supplier?: Supplier;
  items?: PurchaseOrderItem[];
  id?: number;
  status?: PurchaseOrderStatus;

  //ui helpers
  reopening?: boolean;
  inProgress?: boolean;
  complete?: boolean;
}
