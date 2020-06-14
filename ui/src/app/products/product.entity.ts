import { ProductVariation } from './product-variation.entity';

export default class Product {
  id?: number;
  sku?: string;
  title?: string;
  description?: string;
  productDetails?: string;
  sellingPrice?: number;
  height?: number;
  width?: number;
  length?: number;
  weight?: number;
  isActive?: boolean;
  ncm?: string;
  variationsSize?: number;
  productVariations?: ProductVariation[];
}
