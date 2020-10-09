import { Module } from '@nestjs/common';
import { SalesOrderModule } from '../sales-order/sales-order.module';
import { ChartController } from './chart.controller';
import { ChartService } from './chart.service';

@Module({
  imports: [SalesOrderModule],
  controllers: [ChartController],
  providers: [ChartService],
})
export class ChartModule {}
