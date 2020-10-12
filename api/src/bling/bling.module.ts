import { Module, HttpModule } from '@nestjs/common';
import { BlingService } from './bling.service';

@Module({
  imports: [HttpModule],
  providers: [BlingService],
  exports: [BlingService],
})
export class BlingModule {}
