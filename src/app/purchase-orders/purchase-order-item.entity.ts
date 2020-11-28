import { ProductVariationDetailsDTO } from '@app/products/product-variation-details.dto';

export interface PurchaseOrderItem {
  productVariation?: ProductVariationDetailsDTO;
  discount?: number;
  amount?: number;
  price?: number;
  ipi?: number;
}
