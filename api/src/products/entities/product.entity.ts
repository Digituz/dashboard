
import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class Product {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({
    type: "varchar",
    length: 24,
    unique: true,
    nullable: false
  })
  sku: string;

  @Column({
    type: "varchar",
    length: 60,
    nullable: false
  })
  title: string;

  @Column({
    type: "varchar",
    length: 10000,
    default: ""
  })
  description: string;

  @Column({
    name: "selling_price",
    precision: 2,
    nullable: true,
  })
  sellingPrice: number;

  @Column({name: "is_active", default: true })
  isActive: boolean;
}
