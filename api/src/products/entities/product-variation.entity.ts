import {
  Entity,
  Column,
  PrimaryColumn,
  ManyToOne,
  JoinColumn,
} from 'typeorm';
import { Product } from './product.entity';

@Entity()
export class ProductVariation {
  @PrimaryColumn({
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
  })
  sellingPrice: number;

  @ManyToOne(
    type => Product,
    product => product.productVariations,
    {
      nullable: false,
    },
  )
  @JoinColumn({ name: 'product_sku' })
  product: Product;
}
