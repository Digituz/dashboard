import { Injectable } from '@nestjs/common';
import { KeyValuePair } from './key-value-pair.entity';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';

@Injectable()
export class KeyValuePairService {
  constructor(
    @InjectRepository(KeyValuePair)
    private keyValuePairService: Repository<KeyValuePair>,
  ) {}

  set(keyValuePair: KeyValuePair) {
    this.keyValuePairService.save(keyValuePair);
  }

  get(key: string): Promise<KeyValuePair> {
    return this.keyValuePairService.findOne({
      key,
    });
  }
}
