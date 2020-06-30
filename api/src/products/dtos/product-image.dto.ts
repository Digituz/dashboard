import { IsNotEmpty } from 'class-validator';

export class ProductImageDTO {
  @IsNotEmpty()
  imageId: number;
  order: number;
}
