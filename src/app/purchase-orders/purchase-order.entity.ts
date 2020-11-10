import { Supplier } from '@app/supplier/supplier.entity';
import { PurchaseOrderItem } from './purchase-order-item.entity';

export interface PurchaseOrder {
  referenceCode?: number;
  creationDate?: string;
  completionDate?: string;
  discount?: Number;
  shippingPrice?: Number;
  total?: Number;
  supplier?: Supplier;
  items?: PurchaseOrderItem;
}
