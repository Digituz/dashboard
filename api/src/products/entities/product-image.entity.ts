import { Entity, Column, ManyToOne, JoinColumn } from 'typeorm';
import { Product } from './product.entity';
import { Image } from '../../media-library/image.entity';

@Entity()
export class ProductImage {
  @Column({
    name: 'image_order',
  })
  order: number;

  @ManyToOne(
    type => Product,
    product => product.productImages,
    { primary: true, nullable: false },
  )
  @JoinColumn({ name: 'product_id' })
  product?: Product;

  @ManyToOne(type => Image, {
    primary: true,
    nullable: false,
    eager: true,
  })
  @JoinColumn({ name: 'image_id' })
  image: Image;
}
