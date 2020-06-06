import { Entity, Column, PrimaryColumn, OneToMany } from 'typeorm';
import { ProductVariation } from './product-variation.entity';

@Entity()
export class Product {
  @PrimaryColumn({
    type: 'varchar',
    length: 24,
    unique: true,
    nullable: false,
  })
  sku: string;

  @Column({
    type: 'varchar',
    length: 60,
    nullable: false,
  })
  title: string;

  @Column({
    type: 'text',
    default: '',
  })
  description: string;

  @Column({
    name: 'product_details',
    type: 'text',
    default: '',
  })
  productDetails: string;

  @Column({
    name: 'selling_price',
    precision: 2,
    nullable: true,
  })
  sellingPrice: number;

  @Column({
    name: 'height',
    precision: 3,
    nullable: true,
  })
  height: number;

  @Column({
    name: 'width',
    precision: 3,
    nullable: true,
  })
  width: number;

  @Column({
    name: 'length',
    precision: 3,
    nullable: true,
  })
  length: number;

  @Column({
    name: 'weight',
    precision: 3,
    nullable: true,
  })
  weight: number;

  @Column({ name: 'is_active', default: true })
  isActive: boolean;

  @OneToMany(
    type => ProductVariation,
    productVariation => productVariation.product,
    {
      cascade: ['insert', 'update'],
      eager: true
    },
  )
  productVariations: ProductVariation[];

  @Column({
    type: 'varchar',
    length: 10,
    nullable: false,
  })
  ncm: string;
}
