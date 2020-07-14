import {
  Controller,
  Post,
  Body,
  ClassSerializerInterceptor,
  UseInterceptors,
  Param,
} from '@nestjs/common';
import { SaleOrderDTO } from './sale-order.dto';
import { SalesOrderService } from './sales-order.service';
import { SaleOrder } from './entities/sale-order.entity';
import { UpdateSaleOrderStatusDTO } from './update-sale-order-status.dto';
import { PaymentStatus } from './entities/payment-status.enum';

@Controller('sales-order')
@UseInterceptors(ClassSerializerInterceptor)
export class SalesOrderController {
  constructor(private salesOrderService: SalesOrderService) {}

  @Post()
  async save(@Body() saleOrder: SaleOrderDTO): Promise<SaleOrder> {
    const saleOrderPersisted = await this.salesOrderService.save(saleOrder);
    return Promise.resolve(new SaleOrder(saleOrderPersisted));
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
}
