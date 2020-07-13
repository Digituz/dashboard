import { Customer } from "../customers/customer.entity"
import { SaleOrderItemDTO } from "./sale-order-item.dto";
import { PaymentType } from "./entities/payment-type.enum";
import { PaymentStatus } from "./entities/payment-status.enum";
import { ShippingType } from "./entities/shipping-type.enum";

export class SaleOrderDTO {
    id?: number;
    referenceCode?: string;
    customer: Customer;
    items: SaleOrderItemDTO[];
    discount: number;
    paymentType: PaymentType | string;
    paymentStatus: PaymentStatus | string;
    installments: number;
    shippingType: ShippingType | string;
    shippingPrice: number;
    customerName: string;
    shippingStreetAddress: string;
    shippingStreetNumber: string;
    shippingStreetNumber2: string;
    shippingNeighborhood: string;
    shippingCity: string;
    shippingState: string;
    shippingZipAddress: string;
}
