import { Controller, Post, Param } from '@nestjs/common';
import { SaleOrder } from 'src/sales-order/entities/sale-order.entity';
import { BlingService } from './bling.service';
import { SalesOrderService } from 'src/sales-order/sales-order.service';

@Controller('bling')
export class BlingController {
  constructor(
    private blingService: BlingService,
    private salesOrderService: SalesOrderService,
  ) {}

  @Post('/:referenceCode')
  async syncWithBling(
    @Param('referenceCode') referenceCode: string,
  ): Promise<any> {
    const salesOrder = await this.salesOrderService.getByReferenceCode(
      referenceCode,
    );
    return this.blingService.createPurchaseOrder(salesOrder);
  }
}
