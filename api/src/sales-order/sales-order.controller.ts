import { Controller, Post, Body } from '@nestjs/common';
import { SaleOrderDTO } from './sale-order.dto';
import { SalesOrderService } from './sales-order.service';
import { SaleOrder } from './entities/sale-order.entity';

@Controller('sales-order')
export class SalesOrderController {
  constructor(private salesOrderService: SalesOrderService) {}

  @Post()
  saveSaleOrder(@Body() saleOrder: SaleOrderDTO): Promise<SaleOrder> {
    return this.salesOrderService.save(saleOrder);
  }
}
