import { Length, IsNotEmpty  } from 'class-validator';
import { ProductVariationDTO } from './product-variation.dto';
import { ProductImageDTO } from './product-image.dto';

export class ProductDTO {
  @IsNotEmpty()
  @Length(3, 24)
  sku: string;
  
  @IsNotEmpty()
  @Length(5, 60)
  title: string;
  ncm: string;
  description: string;
  productDetails: string;
  sellingPrice: number;
  height: number;
  width: number;
  length: number;
  weight: number;
  isActive: boolean;
  productVariations?: ProductVariationDTO[];
  productImages?: ProductImageDTO[];
}
