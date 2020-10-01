import {
  Entity,
  Column,
  ManyToOne,
  JoinColumn,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { Product } from './product.entity';
import { Image } from '../../media-library/image.entity';

@Entity()
export class ProductImage {
  @PrimaryGeneratedColumn()
  id?: number;

  @Column({
    name: 'image_order',
  })
  order: number;

  @ManyToOne(
    type => Product,
    product => product.productImages,
    { nullable: false, cascade: false },
  )
  @JoinColumn({ name: 'product_id' })
  product?: Product;

  @ManyToOne(type => Image, {
    nullable: false,
    eager: true,
    cascade: false,
  })
  @JoinColumn({ name: 'image_id' })
  image: Image;
}
