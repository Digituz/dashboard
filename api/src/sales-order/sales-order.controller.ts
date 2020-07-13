import { Controller, Post, Body, ClassSerializerInterceptor, UseInterceptors } from '@nestjs/common';
import { SaleOrderDTO } from './sale-order.dto';
import { SalesOrderService } from './sales-order.service';
import { SaleOrder } from './entities/sale-order.entity';

@Controller('sales-order')
export class SalesOrderController {
  constructor(private salesOrderService: SalesOrderService) {}

  @Post()
  @UseInterceptors(ClassSerializerInterceptor)
  async saveSaleOrder(@Body() saleOrder: SaleOrderDTO): Promise<SaleOrder> {
    const saleOrderPersisted = await this.salesOrderService.save(saleOrder);
    return Promise.resolve(new SaleOrder(saleOrderPersisted));
  }
}
