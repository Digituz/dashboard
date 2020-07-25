import { PaymentType } from './payment-type.enum';
import { PaymentStatus } from './payment-status.enum';
import { Column } from 'typeorm';
import { NumericTransformer } from '../../util/numeric-transformer';

export class SaleOrderPayment {
  @Column({
    name: 'discount',
    precision: 2,
    nullable: false,
    transformer: new NumericTransformer(),
  })
  discount: number;

  @Column({
    name: 'total',
    precision: 2,
    nullable: false,
    transformer: new NumericTransformer(),
  })
  total: number;

  @Column({
    name: 'payment_type',
    type: 'varchar',
    length: 60,
    nullable: false,
  })
  paymentType: PaymentType;

  @Column({
    name: 'payment_status',
    type: 'varchar',
    length: 60,
    nullable: false,
  })
  paymentStatus: PaymentStatus;

  @Column({
    name: 'installments',
    type: 'int',
    nullable: false,
  })
  installments: number;
}
