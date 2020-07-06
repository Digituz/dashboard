import Product from '@app/products/product.entity';

export class Inventory {
  id?: number;
  product: Product;
  currentPosition: number;
  movements?: [];
}
