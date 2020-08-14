import { Controller, Post, Param } from '@nestjs/common';
import { BlingService } from './bling.service';
import { SalesOrderService } from '../sales-order/sales-order.service';

@Controller('bling')
export class BlingController {
  constructor(
    private blingService: BlingService,
    private salesOrderService: SalesOrderService,
  ) {}

  @Post('/:referenceCode')
  async syncWithBling(
    @Param('referenceCode') referenceCode: string,
  ): Promise<void> {
    const salesOrder = await this.salesOrderService.getByReferenceCode(
      referenceCode,
    );
    await this.blingService.createPurchaseOrder(salesOrder);
  }
}
