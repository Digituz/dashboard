import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { KeyValuePair } from './key-value-pair.entity';
import { KeyValuePairService } from './key-value-pair.service';

@Module({
  imports: [TypeOrmModule.forFeature([KeyValuePair])],
  controllers: [],
  providers: [KeyValuePairService],
  exports: [KeyValuePairService],
})
export class KeyValuePairModule {}
