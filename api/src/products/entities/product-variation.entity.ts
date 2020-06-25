import {
  Entity,
  Column,
  ManyToOne,
  JoinColumn,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { Product } from './product.entity';
import { BaseEntity } from '../../util/base-entity';

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
  })
  sellingPrice: number;

  @ManyToOne(
    type => Product,
    product => product.productVariations,
    {
      nullable: false,
      onDelete: 'CASCADE',
    },
  )
  @JoinColumn({ name: 'product_id' })
  product: Product;
}
