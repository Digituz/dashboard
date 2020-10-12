import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import randomize from 'randomatic';
import moment from 'moment';

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
import { isNullOrUndefined } from '../util/numeric-transformer';
import { SaleOrderBlingStatus } from './entities/sale-order-bling-status.enum';
import { BlingService } from '../bling/bling.service';

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
    private blingService: BlingService,
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
        if (isNullOrUndefined(options.sortDirectionAscending)) {
          options.sortDirectionAscending = false;
        }
        orderColumn = 'so.creationDate';
        break;
      case 'referenceCode':
        orderColumn = 'so.referenceCode';
        break;
      case 'name':
        orderColumn = 'c.name';
        break;
      case 'total':
        orderColumn = 'so.total';
        break;
      case 'status':
        orderColumn = 'so.paymentStatus';
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
                qb.where(`lower(c.name) like lower(:query)`, {
                  query: `%${queryParam.value.toString()}%`,
                }).orWhere(`lower(c.cpf) like lower(:query)`, {
                  query: `%${queryParam.value.toString()}%`,
                });
              }),
            );
            break;
          case 'paymentStatus':
            queryBuilder.andWhere(`so.paymentDetails.paymentStatus = :status`, {
              status: queryParam.value,
            });
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
      creationDate: saleOrderDTO.creationDate,
      approvalDate: saleOrderDTO.approvalDate,
    };

    if (!isANewSaleOrder) {
      // remove previous items (the new ones will be created below)
      await this.salesOrderItemRepository.query(
        'delete from sale_order_item where sale_order_id = $1;',
        [saleOrder.id],
      );
    }

    if (isANewSaleOrder) {
      saleOrder.creationDate = saleOrder.creationDate || new Date();
    }

    if (
      saleOrder.paymentDetails.paymentStatus === PaymentStatus.APPROVED &&
      !saleOrder.blingStatus
    ) {
      await this.blingService.createPurchaseOrder(saleOrder);
      saleOrder.blingStatus = SaleOrderBlingStatus.EM_ABERTO;
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
          description: `Originário da venda número ${saleOrder.id}`,
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

      if (saleOrder.blingStatus === SaleOrderBlingStatus.EM_ABERTO) {
        saleOrder.blingStatus = SaleOrderBlingStatus.CANCELADO;
        await this.blingService.cancelPurchaseOrder(saleOrder);
      }
    }

    if (status === PaymentStatus.APPROVED) {
      saleOrder.approvalDate = new Date();
      await this.salesOrderRepository.save(saleOrder);
    }

    saleOrder.paymentDetails.paymentStatus = status;
    await this.salesOrderRepository.save(saleOrder);
    return Promise.resolve(saleOrder);
  }

  async getByReferenceCode(referenceCode: string) {
    return this.salesOrderRepository
      .createQueryBuilder('so')
      .leftJoinAndSelect('so.customer', 'c')
      .leftJoinAndSelect('so.items', 'i')
      .leftJoinAndSelect('i.productVariation', 'pv')
      .leftJoinAndSelect('pv.product', 'p')
      .where('so.referenceCode = :referenceCode', {
        referenceCode,
      })
      .getOne();
  }

  async getConfirmedSalesOrders(
    options: IPaginationOpts,
  ): Promise<Pagination<SaleOrder>> {
    const queryBuilder = await this.salesOrderRepository
      .createQueryBuilder('so')
      .leftJoinAndSelect('so.customer', 'c')
      .where('so.paymentStatus = :status', { status: 'APPROVED' })
      .andWhere('so.approvalDate >= :date', {
        date: moment().subtract(3, 'd'),
      })
      .orderBy('so.approvalDate', 'DESC');

    return paginate<SaleOrder>(queryBuilder, options);
  }

  async getSalesForLast7Days() {
    const queryBuilder = await this.salesOrderRepository
      .createQueryBuilder('so')
      .where('so.paymentStatus = :status', { status: 'APPROVED' })
      .andWhere('so.approvalDate >= :date', {
        date: moment().subtract(7, 'd'),
      })
      .orderBy('so.approvalDate', 'DESC')
      .getMany();
    return queryBuilder;
  }
}
