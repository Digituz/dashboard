// ## properties
// discount
// payment terms
// shippment
// shipping details
//
// ## relations
// list of products, which will actually be SaleOrderProduct so we can override a few properties
// a customer
//

import { Entity, Column, ManyToOne } from 'typeorm';
import { BaseEntity } from '../../util/base-entity';
import { SaleOrderShipment } from './sale-order-shipment.entity';
import { SaleOrderPayment } from './sale-order-payment.entity';
import { Customer } from '../../customers/customer.entity';
import { SaleOrderItem } from './sale-order-item.entity';

@Entity()
export class SaleOrder extends BaseEntity {
  @ManyToOne(
    type => Customer,
    { primary: true, nullable: false, cascade: false },
  )
  customer: Customer;

  @ManyToOne(
    type => SaleOrderItem,
    { primary: true, nullable: false, cascade: false },
  )
  items: SaleOrderItem;

  @Column(type => SaleOrderPayment)
  paymentDetails: SaleOrderPayment;

  @Column(type => SaleOrderShipment)
  shipmentDetails: SaleOrderShipment;
}
