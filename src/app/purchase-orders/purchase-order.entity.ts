import { PurchaseOrderItem } from './purchase-order-item.entity';

export interface PurchaseOrder {
  referenceCode?: number;
  creationDate?: Date;
  completionDate?: Date;
  discount?: Number;
  shippingPrice?: Number;
  total?: Number;
  items?: PurchaseOrderItem;
}
