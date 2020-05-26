import { Product } from "../entities/product.entity";

export class CreateProductVariationDTO {
  id: number;
  sku: string;
  description: string;
  sellingPrice: number;
  product: Product;
}
