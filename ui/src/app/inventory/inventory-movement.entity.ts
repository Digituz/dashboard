import Product from '@app/products/product.entity';

export class InventoryMovement {
  product: Product;
  amount: number;
  description: string;
}
