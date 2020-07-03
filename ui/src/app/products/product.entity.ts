import { ProductVariation } from './product-variation.entity';
import { ProductImage } from './product-image.entity';

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
  variationsSize?: number = 0;
  productVariations?: ProductVariation[];
  imagesSize?: number = 0;
  productImages?: ProductImage[];
}
