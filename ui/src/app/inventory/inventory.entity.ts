import { ProductVariation } from '@app/products/product-variation.entity';

export class Inventory {
  id?: number;
  productVariation: ProductVariation;
  currentPosition: number;
  movements?: [];
}
