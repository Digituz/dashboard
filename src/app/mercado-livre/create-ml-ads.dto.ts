import Product from '../products/product.entity';

export class CreateMLAdsDTO {
  categoryId?: string;
  categoryName?: string;
  adType?: string;
  products: Partial<Product>[];
  additionalPrice?: number;
}
