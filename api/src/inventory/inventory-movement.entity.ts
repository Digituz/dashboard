import { Entity, ManyToOne, JoinColumn, Column } from 'typeorm';
import { BaseEntity } from '../util/base-entity';
import { Inventory } from './inventory.entity';

@Entity()
export class InventoryMovement extends BaseEntity {
  @ManyToOne(
    type => Inventory,
    inventory => inventory.movements,
    { primary: true, nullable: false, cascade: false },
  )
  @JoinColumn({ name: 'inventory_id' })
  inventory: Inventory;

  @Column()
  amount: number;

  @Column()
  description: string;
}
