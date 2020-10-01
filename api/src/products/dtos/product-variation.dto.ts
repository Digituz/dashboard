import { Length, IsNotEmpty } from 'class-validator';

export class ProductVariationDTO {
  @IsNotEmpty()
  @Length(5, 24)
  sku: string;

  @IsNotEmpty()
  @Length(5, 24)
  parentSku: string;

  @IsNotEmpty()
  @Length(1, 60)
  description: string;

  sellingPrice: number;
}
