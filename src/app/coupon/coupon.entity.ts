export interface Coupon {
  id: number;
  code: string;
  type: string;
  description: string;
  value: number;
  active: boolean;
}
