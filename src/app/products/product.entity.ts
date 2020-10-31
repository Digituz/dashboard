import { ProductVariation } from './product-variation.entity';
import { ProductImage } from './product-image.entity';
import { ProductCategory } from './product-category.enum';
import { ProductComposition } from './product-composition.entity';

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
  thumbnail?: string;
  variationsSize?: number = 0;
  productVariations?: ProductVariation[];
  productComposition?: ProductComposition[];
  imagesSize?: number = 0;
  productImages?: ProductImage[];
  category?: ProductCategory;
}
