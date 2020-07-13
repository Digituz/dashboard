import { BaseEntity } from '../../util/base-entity';
import { Entity, ManyToOne, Column, JoinColumn } from 'typeorm';
import { Product } from '../../products/entities/product.entity';
import { SaleOrder } from './sale-order.entity';

@Entity()
export class SaleOrderItem extends BaseEntity {
  @ManyToOne(type => Product, {
    primary: true,
    nullable: false,
    cascade: false,
  })
  @JoinColumn({ name: 'product_id' })
  product: Product;

  @ManyToOne(type => SaleOrder, {
    primary: true,
    nullable: false,
    cascade: false,
  })
  @JoinColumn({ name: 'sale_order_id' })
  saleOrder?: SaleOrder;

  @Column({
    name: 'price',
    precision: 2,
    nullable: false,
  })
  price: number;

  @Column({
    name: 'discount',
    precision: 2,
    nullable: false,
  })
  discount: number;

  @Column({
    name: 'amount',
    type: 'int',
    nullable: false,
  })
  amount: number;
}
