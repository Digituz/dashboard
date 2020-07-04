import { IsNotEmpty } from 'class-validator';

export class InventoryMovementDTO {
  @IsNotEmpty()
  sku: string;

  @IsNotEmpty()
  amount: number;

  @IsNotEmpty()
  description: string;
}
