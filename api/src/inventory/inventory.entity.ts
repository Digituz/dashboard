import { Entity, ManyToOne, JoinColumn, OneToMany, Column } from 'typeorm';
import { BaseEntity } from '../util/base-entity';
import { InventoryMovement } from './inventory-movement.entity';
import { ProductVariation } from '../products/entities/product-variation.entity';

@Entity()
export class Inventory extends BaseEntity {
  @ManyToOne(type => ProductVariation, { nullable: false, cascade: false })
  @JoinColumn({ name: 'product_variation_id' })
  productVariation: ProductVariation;

  @Column({
    name: 'current_position',
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
