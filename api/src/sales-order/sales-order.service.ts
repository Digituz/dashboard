import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { v4 as uuidv4 } from 'uuid';

import { SaleOrder } from './entities/sale-order.entity';
import { Repository, In } from 'typeorm';
import { SaleOrderDTO } from './sale-order.dto';
import { SaleOrderItem } from './entities/sale-order-item.entity';
import { CustomersService } from '../customers/customers.service';
import { ProductsService } from '../products/products.service';
import { PaymentType } from './entities/payment-type.enum';
import { PaymentStatus } from './entities/payment-status.enum';
import { ShippingType } from './entities/shipping-type.enum';
import { SaleOrderPayment } from './entities/sale-order-payment.entity';
import { SaleOrderShipment } from './entities/sale-order-shipment.entity';

@Injectable()
export class SalesOrderService {
  constructor(
    @InjectRepository(SaleOrder)
    private salesOrderRepository: Repository<SaleOrder>,
    @InjectRepository(SaleOrderItem)
    private salesOrderItemRepository: Repository<SaleOrderItem>,
    private customersService: CustomersService,
    private productsService: ProductsService,
  ) {}

  private async buildItemsList(
    saleOrderDTO: SaleOrderDTO,
  ): Promise<SaleOrderItem[]> {
    const skus = saleOrderDTO.items.map(item => item.sku);
    const products = await this.productsService.findBySkus(skus);

    return products.map(product => {
      const item = saleOrderDTO.items.find(item => item.sku === product.sku);
      const saleOrderItem = {
        price: item.price,
        discount: item.discount,
        amount: item.amount,
        product: product,
      };
      return saleOrderItem;
    });
  }

  private async createOrUpdateSaleOrder(
    saleOrderDTO: SaleOrderDTO,
  ): Promise<SaleOrder> {
    const items = await this.buildItemsList(saleOrderDTO);
    const customer = await this.customersService.findOrCreate(
      saleOrderDTO.customer,
    );
    const itemsTotal = items.reduce((currentValue, item) => {
      return (item.price - item.discount) * item.amount + currentValue;
    }, 0);
    const total =
      itemsTotal - saleOrderDTO.discount + saleOrderDTO.shippingPrice;

    const referenceCode = uuidv4();
    const paymentDetails: SaleOrderPayment = {
      discount: saleOrderDTO.discount,
      total,
      paymentType: PaymentType[saleOrderDTO.paymentType],
      paymentStatus: PaymentStatus[saleOrderDTO.paymentStatus],
      installments: saleOrderDTO.installments,
    };
    const shipmentDetails: SaleOrderShipment = {
      shippingType: ShippingType[saleOrderDTO.shippingType],
      shippingPrice: saleOrderDTO.shippingPrice,
      customerName: saleOrderDTO.customerName,
      shippingStreetAddress: saleOrderDTO.shippingStreetAddress,
      shippingStreetNumber: saleOrderDTO.shippingStreetNumber,
      shippingStreetNumber2: saleOrderDTO.shippingStreetNumber2,
      shippingNeighborhood: saleOrderDTO.shippingNeighborhood,
      shippingCity: saleOrderDTO.shippingCity,
      shippingState: saleOrderDTO.shippingState,
      shippingZipAddress: saleOrderDTO.shippingZipAddress.replace(/\D/g, ''),
    };

    const saleOrder: SaleOrder = {
      id: saleOrderDTO.id || null,
      referenceCode,
      customer,
      items,
      paymentDetails,
      shipmentDetails,
    };

    if (saleOrderDTO.id) {
      const oldItems = await this.salesOrderItemRepository.find({
        where: {
          id: In(items.map(item => item.id)),
        },
      });
      await this.salesOrderItemRepository.remove(oldItems);
    }

    const persistedSaleOrder = await this.salesOrderRepository.save(saleOrder);
    const persistedItems = await this.salesOrderItemRepository.save(
      items.map(item => ({
        saleOrder: persistedSaleOrder,
        ...item,
      })),
    );

    persistedSaleOrder.items = persistedItems;
    
    return Promise.resolve(persistedSaleOrder);
  }

  save(saleOrderDTO: SaleOrderDTO): Promise<SaleOrder> {
    return this.createOrUpdateSaleOrder(saleOrderDTO);
  }
}
