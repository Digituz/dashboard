import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { SaleOrder } from './entities/sale-order.entity';
import { SaleOrderItem } from './entities/sale-order-item.entity';

@Module({
  imports: [TypeOrmModule.forFeature([SaleOrder, SaleOrderItem])],
  providers: [],
  controllers: [],
})
export class SalesOrderModule {}
