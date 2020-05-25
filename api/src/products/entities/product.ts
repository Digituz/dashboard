
import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class Product {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  sku: string;

  @Column()
  title: string;

  @Column()
  description: string;

  @Column()
  sellingPrice: number;

  @Column({ default: true })
  isActive: boolean;
}
