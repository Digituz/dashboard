import { Module, HttpModule } from '@nestjs/common';
import { BlingService } from './bling.service';
import { SalesOrderModule } from '../sales-order/sales-order.module';

@Module({
  imports: [HttpModule, SalesOrderModule],
  providers: [BlingService],
})
export class BlingModule {}
