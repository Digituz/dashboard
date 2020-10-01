import { Entity, ManyToOne, JoinColumn, Column } from 'typeorm';
import { BaseEntity } from '../util/base-entity';
import { Inventory } from './inventory.entity';
import { SaleOrder } from '../sales-order/entities/sale-order.entity';

@Entity()
export class InventoryMovement extends BaseEntity {
  @ManyToOne(
    type => Inventory,
    inventory => inventory.movements,
    { nullable: false, cascade: false, eager: true },
  )
  @JoinColumn({ name: 'inventory_id' })
  inventory: Inventory;

  @ManyToOne(type => SaleOrder, { nullable: true, cascade: false })
  @JoinColumn({ name: 'sale_order_id' })
  saleOrder?: SaleOrder;

  @Column()
  amount: number;

  @Column()
  description: string;
}
