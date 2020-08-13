import { Transform } from 'class-transformer';
import { Entity, Column, ManyToOne, OneToMany, JoinColumn } from 'typeorm';

import { BaseEntity } from '../../util/base-entity';
import { SaleOrderShipment } from './sale-order-shipment.entity';
import { SaleOrderPayment } from './sale-order-payment.entity';
import { Customer } from '../../customers/customer.entity';
import { SaleOrderItem } from './sale-order-item.entity';
import { SaleOrderBlingStatus } from './sale-order-bling-status.enum';

@Entity()
export class SaleOrder extends BaseEntity {
  constructor(partial: Partial<SaleOrder>) {
    super();
    Object.assign(this, partial);
  }

  @Column({
    name: 'reference_code',
    type: 'varchar',
    length: 36,
    unique: true,
    nullable: false,
  })
  referenceCode: string;

  @Column({
    name: 'bling_status',
    type: 'varchar',
    length: 30,
    unique: false,
    nullable: true,
  })
  blingStatus?: SaleOrderBlingStatus;

  @ManyToOne(type => Customer, {
    nullable: false,
    cascade: false,
  })
  @JoinColumn({ name: 'customer_id' })
  customer: Customer;

  @OneToMany(
    type => SaleOrderItem,
    item => item.saleOrder,
    { cascade: false },
  )
  @Transform(items =>
    items.map(item => ({
      id: item.id,
      product: item.product,
      amount: item.amount,
      price: item.price,
      discount: item.discount,
    })),
  )
  items: SaleOrderItem[];

  @Column(type => SaleOrderPayment, { prefix: false })
  paymentDetails: SaleOrderPayment;

  @Column(type => SaleOrderShipment, { prefix: false })
  shipmentDetails: SaleOrderShipment;

  @Column({
    name: 'creation_date',
    type: 'timestamp',
    unique: false,
    nullable: true,
  })
  creationDate?: Date;

  @Column({
    name: 'approval_date',
    type: 'timestamp',
    unique: false,
    nullable: true,
  })
  approvalDate?: Date;

  @Column({
    name: 'cancellation_date',
    type: 'timestamp',
    unique: false,
    nullable: true,
  })
  cancellationDate?: Date;
}
