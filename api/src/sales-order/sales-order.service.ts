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
import { InventoryService } from '../inventory/inventory.service';
import { InventoryMovementDTO } from '../inventory/inventory-movement.dto';

@Injectable()
export class SalesOrderService {
  constructor(
    @InjectRepository(SaleOrder)
    private salesOrderRepository: Repository<SaleOrder>,
    @InjectRepository(SaleOrderItem)
    private salesOrderItemRepository: Repository<SaleOrderItem>,
    private customersService: CustomersService,
    private productsService: ProductsService,
    private inventoryService: InventoryService,
  ) {}

  private async buildItemsList(
    saleOrderDTO: SaleOrderDTO,
  ): Promise<SaleOrderItem[]> {
    const skus = saleOrderDTO.items.map(item => item.sku);
    const productsVariations = await this.productsService.findVariationsBySkus(skus);

    return productsVariations.map(productVariation => {
      const item = saleOrderDTO.items.find(item => item.sku === productVariation.sku);
      const saleOrderItem = {
        price: item.price,
        discount: item.discount,
        amount: item.amount,
        productVariation: productVariation,
      };
      return saleOrderItem;
    });
  }

  private async createOrUpdateSaleOrder(
    saleOrderDTO: SaleOrderDTO,
  ): Promise<SaleOrder> {
    const isANewSaleOrder = !saleOrderDTO.id;
    const items = await this.buildItemsList(saleOrderDTO);
    const customer = await this.customersService.findOrCreate(
      saleOrderDTO.customer,
    );
    const itemsTotal = items.reduce((currentValue, item) => {
      return (item.price - item.discount) * item.amount + currentValue;
    }, 0);
    const total =
      itemsTotal - saleOrderDTO.discount + saleOrderDTO.shippingPrice;

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
      referenceCode: saleOrderDTO.referenceCode || uuidv4(),
      customer,
      items,
      paymentDetails,
      shipmentDetails,
    };

    if (!isANewSaleOrder) {
      // remove previous items (the new ones will be created below)
      await this.salesOrderItemRepository.query(
        'delete from sale_order_item where sale_order_id = $1;',
        [saleOrder.id],
      );
    }

    const persistedSaleOrder = await this.salesOrderRepository.save(saleOrder);

    // create the new items
    const persistedItems = await this.salesOrderItemRepository.save(
      items.map(item => ({
        saleOrder: persistedSaleOrder,
        ...item,
      })),
    );

    persistedSaleOrder.items = persistedItems;

    // removing old movements
    if (!isANewSaleOrder) {
      await this.inventoryService.cleanUpMovements(persistedSaleOrder);
    }

    // creating movements to update inventory position
    const movementJobs = persistedItems.map(item => {
      return new Promise(async res => {
        const movement: InventoryMovementDTO = {
          sku: item.productVariation.sku,
          amount: -item.amount,
          description: `${saleOrder.id}`,
        };
        await this.inventoryService.saveMovement(movement, persistedSaleOrder);
        res();
      });
    });
    await Promise.all(movementJobs);

    return Promise.resolve(persistedSaleOrder);
  }

  save(saleOrderDTO: SaleOrderDTO): Promise<SaleOrder> {
    return this.createOrUpdateSaleOrder(saleOrderDTO);
  }

  async updateStatus(
    referenceCode: string,
    status: PaymentStatus,
  ): Promise<SaleOrder> {
    const saleOrder = await this.salesOrderRepository.findOne({
      where: { referenceCode },
    });

    if (saleOrder.paymentDetails.paymentStatus === PaymentStatus.CANCELLED) {
      throw new Error('Sale order was cancelled already.');
    }

    if (status === PaymentStatus.CANCELLED) {
      // we must remove movements when payment gets cancelled
      await this.inventoryService.cleanUpMovements(saleOrder);
    }

    saleOrder.paymentDetails.paymentStatus = status;
    await this.salesOrderRepository.save(saleOrder);
    return Promise.resolve(saleOrder);
  }
}
