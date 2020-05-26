import { Entity, Column, PrimaryGeneratedColumn, OneToMany } from 'typeorm';
import { ProductVariation } from './product-variation.entity';

@Entity()
export class Product {
  @PrimaryGeneratedColumn()
  id: number;

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
    name: 'selling_price',
    precision: 2,
    nullable: true,
  })
  sellingPrice: number;

  @Column({ name: 'is_active', default: true })
  isActive: boolean;

  @OneToMany(
    type => ProductVariation,
    productVariation => productVariation.product,
    {
      cascade: ['insert', 'update'],
    },
  )
  productVariations: ProductVariation[];
}
