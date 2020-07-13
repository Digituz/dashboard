import { Entity, Column, ManyToOne, OneToMany, JoinColumn } from 'typeorm';
import { BaseEntity } from '../../util/base-entity';
import { SaleOrderShipment } from './sale-order-shipment.entity';
import { SaleOrderPayment } from './sale-order-payment.entity';
import { Customer } from '../../customers/customer.entity';
import { SaleOrderItem } from './sale-order-item.entity';

@Entity()
export class SaleOrder extends BaseEntity {
  @Column({
    name: 'reference_code',
    type: 'varchar',
    length: 36,
    unique: true,
    nullable: false,
  })
  referenceCode: string;

  @ManyToOne(
    type => Customer,
    { primary: true, nullable: false, cascade: false },
  )
  @JoinColumn({ name: 'customer_id' })
  customer: Customer;

  @OneToMany(
    type => SaleOrderItem,
    item => item.saleOrder,
    { cascade: false },
  )
  items: SaleOrderItem[];

  @Column(type => SaleOrderPayment, { prefix: false })
  paymentDetails: SaleOrderPayment;

  @Column(type => SaleOrderShipment, { prefix: false })
  shipmentDetails: SaleOrderShipment;
}
