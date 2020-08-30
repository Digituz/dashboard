import { Entity, Column, OneToMany } from 'typeorm';
import { ProductVariation } from './product-variation.entity';
import { BaseEntity } from '../../util/base-entity';
import { ProductImage } from './product-image.entity';
import { NumericTransformer } from '../../util/numeric-transformer';
import { ProductCategory } from './product-category.enum';
import { ProductComposition } from './product-composition.entity';

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
    name: 'category',
    type: 'varchar',
    length: 60,
    nullable: false,
  })
  category?: ProductCategory;

  @Column({
    type: 'text',
    default: '',
  })
  description?: string;

  @Column({
    name: 'product_details',
    type: 'text',
    default: '',
  })
  productDetails?: string;

  @Column({
    name: 'selling_price',
    precision: 2,
    nullable: true,
    transformer: new NumericTransformer(),
  })
  sellingPrice?: number;

  @Column({
    name: 'height',
    precision: 3,
    nullable: true,
    transformer: new NumericTransformer(),
  })
  height?: number;

  @Column({
    name: 'width',
    precision: 3,
    nullable: true,
    transformer: new NumericTransformer(),
  })
  width?: number;

  @Column({
    name: 'length',
    precision: 3,
    nullable: true,
    transformer: new NumericTransformer(),
  })
  length?: number;

  @Column({
    name: 'weight',
    precision: 3,
    nullable: true,
    transformer: new NumericTransformer(),
  })
  weight?: number;

  @Column({ name: 'is_active', default: true })
  isActive: boolean;

  @OneToMany(
    type => ProductVariation,
    productVariation => productVariation.product,
    { cascade: false, eager: true },
  )
  productVariations?: ProductVariation[];

  @OneToMany(
    type => ProductComposition,
    productComposition => productComposition.product,
    { cascade: false, eager: true },
  )
  productComposition?: ProductComposition[];

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
  variationsSize: number = 0;

  @OneToMany(
    type => ProductImage,
    image => image.product,
    {
      cascade: false,
      eager: false,
    },
  )
  productImages?: ProductImage[];

  @Column({
    name: 'images_size',
    type: 'int',
  })
  imagesSize: number = 0;

  @Column({
    name: 'shopify_id',
    type: 'bigint',
  })
  shopifyId?: number;

  @Column({
    name: 'mercado_livre_id',
    type: 'varchar',
    length: 30,
    nullable: true,
  })
  mercadoLivreId?: string;

  @Column({
    name: 'mercado_livre_category_id',
    type: 'varchar',
    length: 60,
    nullable: true,
  })
  mercadoLivreCategoryId?: string;
}
