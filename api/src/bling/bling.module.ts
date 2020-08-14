import { Module, HttpModule } from '@nestjs/common';
import { BlingService } from './bling.service';
import { SalesOrderModule } from '../sales-order/sales-order.module';
import { BlingController } from './bling.controller';

@Module({
  imports: [HttpModule, SalesOrderModule],
  providers: [BlingService],
  controllers: [BlingController],
})
export class BlingModule {}
