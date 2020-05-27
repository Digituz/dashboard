import { Length, IsNotEmpty  } from 'class-validator';

import { Product } from '../entities/product.entity';

export class CreateProductVariationDTO {
  id: number;

  @IsNotEmpty()
  @Length(5, 24)
  sku: string;

  @IsNotEmpty()
  @Length(5, 60)
  description: string;

  sellingPrice: number;

  product: Product;
}
