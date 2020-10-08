import { Module, HttpModule, forwardRef } from '@nestjs/common';
import { BlingService } from './bling.service';
import { SalesOrderModule } from '../sales-order/sales-order.module';
import { BlingController } from './bling.controller';

@Module({
  imports: [HttpModule, forwardRef(() => SalesOrderModule)],
  providers: [BlingService],
  controllers: [BlingController],
  exports: [BlingService],
})
export class BlingModule {}
