import { Controller, Post, Param, Delete } from '@nestjs/common';
import { BlingService } from './bling.service';
import { SalesOrderService } from '../sales-order/sales-order.service';
import { PaymentStatus } from '../sales-order/entities/payment-status.enum';
import { SaleOrderBlingStatus } from '../sales-order/entities/sale-order-bling-status.enum';

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

  @Delete('/:referenceCode')
  async cancelOnBling(
    @Param('referenceCode') referenceCode: string,
  ): Promise<void> {
    const salesOrder = await this.salesOrderService.getByReferenceCode(
      referenceCode,
    );
    salesOrder.paymentDetails.paymentStatus = PaymentStatus.CANCELLED;
    await this.blingService.cancelPurchaseOrder(salesOrder);
    await this.salesOrderService.updateStatus(
      salesOrder.referenceCode,
      PaymentStatus.CANCELLED,
    );
    await this.salesOrderService.updateBlingStatus(
      salesOrder.referenceCode,
      SaleOrderBlingStatus.CANCELADO,
    );
  }
}
