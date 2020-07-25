import { BaseEntity } from '../../util/base-entity';
import { Entity, ManyToOne, Column, JoinColumn } from 'typeorm';
import { SaleOrder } from './sale-order.entity';
import { ProductVariation } from '../../products/entities/product-variation.entity';
import { NumericTransformer } from '../../util/numeric-transformer';

@Entity()
export class SaleOrderItem extends BaseEntity {
  @ManyToOne(type => ProductVariation, {
    nullable: false,
    cascade: false,
  })
  @JoinColumn({ name: 'product_variation_id' })
  productVariation: ProductVariation;

  @ManyToOne(type => SaleOrder, {
    nullable: false,
    cascade: false,
  })
  @JoinColumn({ name: 'sale_order_id' })
  saleOrder?: SaleOrder;

  @Column({
    name: 'price',
    precision: 2,
    nullable: false,
    transformer: new NumericTransformer(),
  })
  price: number;

  @Column({
    name: 'discount',
    precision: 2,
    nullable: false,
    transformer: new NumericTransformer(),
  })
  discount: number;

  @Column({
    name: 'amount',
    precision: 2,
    nullable: false,
    transformer: new NumericTransformer(),
  })
  amount: number;
}
