import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import randomize from 'randomatic';

import { SaleOrder } from './entities/sale-order.entity';
import { Repository, Brackets } from 'typeorm';
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
import { IPaginationOpts } from '../pagination/pagination';
import { Pagination, paginate } from 'nestjs-typeorm-paginate';

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

  async paginate(options: IPaginationOpts): Promise<Pagination<SaleOrder>> {
    const queryBuilder = this.salesOrderRepository.createQueryBuilder('so');

    queryBuilder
      .leftJoinAndSelect('so.customer', 'c')
      .leftJoinAndSelect('so.items', 'i')
      .leftJoinAndSelect('i.productVariation', 'pv');

    let orderColumn = '';

    switch (options.sortedBy?.trim()) {
      case undefined:
      case null:
      case 'date':
        orderColumn = 'so.creationDate';
        break;
      case 'name':
        orderColumn = 'c.name';
        break;
      case 'total':
        orderColumn = 'so.paymentDetails.total';
        break;
      default:
        orderColumn = options.sortedBy;
    }

    options.queryParams
      .filter(queryParam => {
        return (
          queryParam !== null &&
          queryParam.value !== null &&
          queryParam.value !== undefined
        );
      })
      .forEach(queryParam => {
        switch (queryParam.key) {
          case 'query':
            queryBuilder.andWhere(
              new Brackets(qb => {
                qb.where(`lower(c.name) like :query`, {
                  query: `%${queryParam.value.toString().toLowerCase()}%`,
                }).orWhere(`lower(c.cpf) like :query`, {
                  query: `%${queryParam.value.toString().toLowerCase()}%`,
                });
              }),
            );
            break;
        }
      });

    let sortDirection;
    let sortNulls;
    switch (options.sortDirectionAscending) {
      case undefined:
      case null:
      case true:
        sortDirection = 'ASC';
        sortNulls = 'NULLS FIRST';
        break;
      default:
        sortDirection = 'DESC';
        sortNulls = 'NULLS LAST';
    }

    queryBuilder.orderBy(orderColumn, sortDirection, sortNulls);

    return paginate<SaleOrder>(queryBuilder, options);
  }

  private async buildItemsList(
    saleOrderDTO: SaleOrderDTO,
  ): Promise<SaleOrderItem[]> {
    const skus = saleOrderDTO.items.map(item => item.sku);
    const productsVariations = await this.productsService.findVariationsBySkus(
      skus,
    );

    return productsVariations.map(productVariation => {
      const item = saleOrderDTO.items.find(
        item => item.sku === productVariation.sku,
      );
      const saleOrderItem = {
        price: item.price,
        discount: item.discount || 0,
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
      itemsTotal - (saleOrderDTO.discount || 0) + saleOrderDTO.shippingPrice;

    const paymentDetails: SaleOrderPayment = {
      discount: saleOrderDTO.discount || 0,
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
      referenceCode: saleOrderDTO.referenceCode || randomize('0', 10),
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

    if (isANewSaleOrder) {
      saleOrder.creationDate = new Date();
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
      saleOrder.cancellationDate = new Date();
      await this.inventoryService.cleanUpMovements(saleOrder);
    }

    if (status === PaymentStatus.APPROVED) {
      saleOrder.approvalDate = new Date();
    }

    saleOrder.paymentDetails.paymentStatus = status;
    await this.salesOrderRepository.save(saleOrder);
    return Promise.resolve(saleOrder);
  }
}
