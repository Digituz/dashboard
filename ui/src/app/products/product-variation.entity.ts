import Product from './product.entity';

export class ProductVariation {
  parentSku: string;
  sku: string;
  description: string;
  sellingPrice: number;
  product?: Product;
}
