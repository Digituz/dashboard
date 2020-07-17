import { ProductVariation } from '@app/products/product-variation.entity';

export class InventoryMovement {
  productVariation: ProductVariation;
  amount: number;
  description: string;
}
