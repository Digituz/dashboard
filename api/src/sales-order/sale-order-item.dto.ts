export class SaleOrderItemDTO {
  sku: string;
  completeDescription?: string;
  price: number;
  discount: number;
  amount: number;
  currentPosition?: number;
}
