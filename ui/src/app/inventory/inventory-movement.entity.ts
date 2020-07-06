import { Inventory } from '@app/inventory/inventory.entity';

export class InventoryMovement {
  inventory: Inventory;
  amount: number;
  description: string;
}
