import {
  Controller,
  Post,
  Body,
  ClassSerializerInterceptor,
  UseInterceptors,
  Param,
  Get,
  Query,
  UseGuards,
  Delete,
} from '@nestjs/common';
import { Pagination } from 'nestjs-typeorm-paginate';

import { SaleOrderDTO } from './sale-order.dto';
import { SalesOrderService } from './sales-order.service';
import { SaleOrder } from './entities/sale-order.entity';
import { UpdateSaleOrderStatusDTO } from './update-sale-order-status.dto';
import { PaymentStatus } from './entities/payment-status.enum';
import { parseBoolean } from '../util/parsers';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';

@Controller('sales-order')
@UseGuards(JwtAuthGuard)
@UseInterceptors(ClassSerializerInterceptor)
export class SalesOrderController {
  constructor(private salesOrderService: SalesOrderService) {}

  @Get()
  async findAll(
    @Query('page') page: number = 1,
    @Query('limit') limit: number = 10,
    @Query('sortedBy') sortedBy: string,
    @Query('sortDirectionAscending') sortDirectionAscending: string,
    @Query('query') query: string,
    @Query('paymentStatus') paymentStatus: string,
  ): Promise<Pagination<SaleOrderDTO>> {
    const results = await this.salesOrderService.paginate({
      page,
      limit,
      sortedBy,
      sortDirectionAscending: parseBoolean(sortDirectionAscending),
      queryParams: [
        {
          key: 'query',
          value: query,
        },
        {
          key: 'paymentStatus',
          value: PaymentStatus[paymentStatus],
        },
      ],
    });

    return {
      ...results,
      items: results.items.map(saleOrder => {
        return {
          id: saleOrder.id,
          referenceCode: saleOrder.referenceCode,
          customer: saleOrder.customer,
          items: saleOrder.items.map(item => ({
            sku: item.productVariation.sku,
            price: item.price,
            discount: item.discount,
            amount: item.amount,
            currentPosition: item.productVariation.currentPosition,
          })),
          discount: saleOrder.paymentDetails.discount,
          paymentType: saleOrder.paymentDetails.paymentType,
          paymentStatus: saleOrder.paymentDetails.paymentStatus,
          installments: saleOrder.paymentDetails.installments,
          shippingType: saleOrder.shipmentDetails.shippingType,
          shippingPrice: saleOrder.shipmentDetails.shippingPrice,
          customerName: saleOrder.shipmentDetails.customerName,
          shippingStreetAddress:
            saleOrder.shipmentDetails.shippingStreetAddress,
          shippingStreetNumber: saleOrder.shipmentDetails.shippingStreetNumber,
          shippingStreetNumber2:
            saleOrder.shipmentDetails.shippingStreetNumber2,
          shippingNeighborhood: saleOrder.shipmentDetails.shippingNeighborhood,
          shippingCity: saleOrder.shipmentDetails.shippingCity,
          shippingState: saleOrder.shipmentDetails.shippingState,
          shippingZipAddress: saleOrder.shipmentDetails.shippingZipAddress,
          creationDate: saleOrder.creationDate,
          approvalDate: saleOrder.approvalDate,
          cancellationDate: saleOrder.cancellationDate,
          total: saleOrder.paymentDetails.total,
          blingStatus: saleOrder.blingStatus,
        };
      }),
    };
  }

  @Get('/confirmed-sales-orders')
  async getConfirmedSalesOrders(
    @Query('page') page: number = 1,
    @Query('limit') limit: number = 10,
    @Query('sortedBy') sortedBy: string,
    @Query('sortDirectionAscending') sortDirectionAscending: string,
    @Query('query') query: string,
  ): Promise<Pagination<SaleOrder>> {
    return this.salesOrderService.getConfirmedSalesOrders({
      page,
      limit,
      sortedBy,
      sortDirectionAscending: parseBoolean(sortDirectionAscending),
      queryParams: [
        {
          key: 'query',
          value: query,
        },
      ],
    });
  }

  @Post()
  async save(@Body() saleOrder: SaleOrderDTO): Promise<SaleOrder> {
    const saleOrderPersisted = await this.salesOrderService.save(saleOrder);
    return Promise.resolve(new SaleOrder(saleOrderPersisted));
  }

  @Delete('/:referenceCode')
  async cancelOnBling(
    @Param('referenceCode') referenceCode: string,
  ): Promise<void> {
    await this.salesOrderService.updateStatus(
      referenceCode,
      PaymentStatus.CANCELLED,
    );
  }

  @Post(':referenceCode')
  async updateStatus(
    @Body() updateDTO: UpdateSaleOrderStatusDTO,
    @Param('referenceCode') referenceCode: string,
  ): Promise<SaleOrder> {
    const saleOrderPersisted = await this.salesOrderService.updateStatus(
      referenceCode,
      PaymentStatus[updateDTO.status],
    );
    return Promise.resolve(new SaleOrder(saleOrderPersisted));
  }

  @Get(':referenceCode')
  async getOne(
    @Param('referenceCode') referenceCode: string,
  ): Promise<SaleOrderDTO> {
    const saleOrder = await this.salesOrderService.getByReferenceCode(
      referenceCode,
    );
    return {
      id: saleOrder.id,
      referenceCode: saleOrder.referenceCode,
      customer: saleOrder.customer,
      items: saleOrder.items.map(item => ({
        sku: item.productVariation.sku,
        completeDescription: `${item.productVariation.sku} - ${item.productVariation.product.title} (${item.productVariation.description})`,
        price: item.price,
        discount: item.discount,
        amount: item.amount,
        currentPosition: item.productVariation.currentPosition,
      })),
      discount: saleOrder.paymentDetails.discount,
      paymentType: saleOrder.paymentDetails.paymentType,
      paymentStatus: saleOrder.paymentDetails.paymentStatus,
      installments: saleOrder.paymentDetails.installments,
      shippingType: saleOrder.shipmentDetails.shippingType,
      shippingPrice: saleOrder.shipmentDetails.shippingPrice,
      customerName: saleOrder.shipmentDetails.customerName,
      shippingStreetAddress: saleOrder.shipmentDetails.shippingStreetAddress,
      shippingStreetNumber: saleOrder.shipmentDetails.shippingStreetNumber,
      shippingStreetNumber2: saleOrder.shipmentDetails.shippingStreetNumber2,
      shippingNeighborhood: saleOrder.shipmentDetails.shippingNeighborhood,
      shippingCity: saleOrder.shipmentDetails.shippingCity,
      shippingState: saleOrder.shipmentDetails.shippingState,
      shippingZipAddress: saleOrder.shipmentDetails.shippingZipAddress,
      creationDate: saleOrder.creationDate,
      approvalDate: saleOrder.approvalDate,
      cancellationDate: saleOrder.cancellationDate,
      total: saleOrder.paymentDetails.total,
      blingStatus: saleOrder.blingStatus,
    };
  }
}
