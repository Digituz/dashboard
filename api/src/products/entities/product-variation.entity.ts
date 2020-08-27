import { Entity, Column, ManyToOne, JoinColumn } from 'typeorm';
import { Product } from './product.entity';
import { BaseEntity } from '../../util/base-entity';
import { NumericTransformer } from '../../util/numeric-transformer';

@Entity()
export class ProductVariation extends BaseEntity {
  @Column({
    type: 'varchar',
    length: 24,
    unique: true,
    nullable: false,
  })
  sku: string;

  @Column({
    type: 'varchar',
    length: 30,
    default: '',
  })
  description: string;

  @Column({
    name: 'selling_price',
    precision: 2,
    nullable: true,
    transformer: new NumericTransformer(),
  })
  sellingPrice?: number;

  @ManyToOne(
    type => Product,
    product => product.productVariations,
    {
      nullable: false,
      cascade: false,
    },
  )
  @JoinColumn({ name: 'product_id' })
  product?: Product;

  @Column({ name: 'current_position' })
  currentPosition?: number;

  @Column({
    name: 'shopify_id',
    type: 'bigint',
  })
  shopifyId?: number = 0;

  @Column({
    name: 'shopify_inventory_id',
    type: 'bigint',
  })
  shopifyInventoryId?: number = 0;
}
