import { Entity, ManyToOne, JoinColumn, OneToMany, Column } from 'typeorm';
import { Product } from '../products/entities/product.entity';
import { BaseEntity } from '../util/base-entity';
import { InventoryMovement } from './inventory-movement.entity';

@Entity()
export class Inventory extends BaseEntity {
  @ManyToOne(
    type => Product,
    product => product.productImages,
    { primary: true, nullable: false, cascade: false },
  )
  @JoinColumn({ name: 'product_id' })
  product?: Product;

  @Column({
    type: 'int',
    nullable: false,
  })
  currentPosition: number = 0;

  @OneToMany(
    type => InventoryMovement,
    inventoryMovement => inventoryMovement.inventory,
  )
  movements: InventoryMovement[];
}
