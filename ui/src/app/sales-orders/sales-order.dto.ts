import { Customer } from "@app/customers/customer.entity";
import { SaleOrderItemDTO } from './sale-order-item.dto';
import { PaymentType } from './payment-type.enum';
import { PaymentStatus } from './payment-status.enum';
import { ShippingType } from './shipping-type.enum';
import { SaleOrderBlingStatus } from './sale-order-bling-status.enum';

export class SalesOrderDTO {
  id?: number;
  referenceCode?: string;
  customer?: Customer;
  items?: SaleOrderItemDTO[];
  discount?: number;
  paymentType?: PaymentType;
  paymentStatus?: PaymentStatus;
  installments?: number;
  shippingType?: ShippingType;
  shippingPrice?: number;
  customerName?: string;
  shippingStreetAddress?: string;
  shippingStreetNumber?: string;
  shippingStreetNumber2?: string;
  shippingNeighborhood?: string;
  shippingCity?: string;
  shippingState?: string;
  shippingZipAddress?: string;
  creationDate?: Date;
  approvalDate?: Date;
  cancellationDate?: Date;
  total?: number;
  blingStatus?: SaleOrderBlingStatus | string;
}
