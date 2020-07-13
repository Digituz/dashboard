import { BaseEntity } from '../../util/base-entity';
import { Entity, ManyToOne, Column } from 'typeorm';
import { Product } from '../../products/entities/product.entity';

@Entity()
export class SaleOrderItem extends BaseEntity {
  @ManyToOne(type => Product, {
    primary: true,
    nullable: false,
    cascade: false,
  })
  product: Product;

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
    name: 'images_size',
    type: 'int',
    nullable: false,
  })
  amount: number;
}
