import { Length, IsNotEmpty  } from 'class-validator';

export class CreateProductDTO {
  @IsNotEmpty()
  @Length(5, 24)
  sku: string;
  
  @IsNotEmpty()
  @Length(5, 60)
  title: string;
  description: string;
  sellingPrice: number;
  isActive: boolean;
}
