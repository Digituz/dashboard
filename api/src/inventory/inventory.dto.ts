import { BaseEntity } from '../util/base-entity';
import { ProductVariationDetailsDTO } from '../products/dtos/product-variation-details.dto';

export class InventoryDTO extends BaseEntity {
  id: number;
  productVariationDetails: ProductVariationDetailsDTO;
  currentPosition: number;
}
