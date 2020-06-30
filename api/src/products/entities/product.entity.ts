import { Entity, Column, OneToMany } from 'typeorm';
import { ProductVariation } from './product-variation.entity';
import { BaseEntity } from '../../util/base-entity';
import { ProductImage } from './product-image.entity';

@Entity()
export class Product extends BaseEntity {
  @Column({
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
      cascade: ['insert', 'update', 'remove'],
      eager: true,
    },
  )
  productVariations: ProductVariation[];

  @Column({
    type: 'varchar',
    length: 10,
    nullable: false,
  })
  ncm: string;

  @Column({
    name: 'variations_size',
    type: 'int',
  })
  variationsSize?: number;

  @OneToMany(
    type => ProductImage,
    image => image.product,
    {
      cascade: ['insert', 'update', 'remove'],
      eager: true,
    },
  )
  productImages?: ProductImage[];

  @Column({
    name: 'images_size',
    type: 'int',
  })
  imagesSize?: number;
}
