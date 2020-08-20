import { Entity, ManyToOne, JoinColumn } from 'typeorm';
import { Product } from './product.entity';
import { ProductVariation } from './product-variation.entity';
import { BaseEntity } from '../../util/base-entity';

@Entity()
export class ProductComposition extends BaseEntity {
  @ManyToOne(
    type => Product,
    product => product.productComposition,
    {
      nullable: false,
      cascade: false,
    },
  )
  @JoinColumn({ name: 'product_id' })
  product?: Product;

  @ManyToOne(type => ProductVariation, {
    nullable: false,
    cascade: false,
  })
  @JoinColumn({ name: 'product_variation_id' })
  productVariation?: ProductVariation;
}
