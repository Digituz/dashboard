import { IsNotEmpty } from 'class-validator';

export class InventoryMovementDTO {
  @IsNotEmpty()
  inventoryId: number;

  @IsNotEmpty()
  amount: number;

  @IsNotEmpty()
  description: string;
}
