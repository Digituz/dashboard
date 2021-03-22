export interface Coupon {
  id: number;
  code: string;
  type: string;
  description: string;
  value: number;
  expirationDate?: Date;
  active: boolean;
}
