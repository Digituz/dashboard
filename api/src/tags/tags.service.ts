import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Tag } from './tag.entity';

@Injectable()
export class TagsService {
  constructor(
    @InjectRepository(Tag)
    private tagsRepository: Repository<Tag>,
  ) {}

  async save(tag: Tag): Promise<Tag> {
    return this.tagsRepository.save(tag);
  }

  async query(query: string): Promise<Tag[]> {
    return this.tagsRepository
      .createQueryBuilder('tag')
      .where('tag.label like :query', { query: `%${query.toLowerCase()}%` })
      .orWhere('tag.description like :query', { query: `%${query.toLowerCase()}%` })
      .limit(10)
      .getMany();
  }

  async findByIds(ids: string[]): Promise<Tag[]> {
    return this.tagsRepository.findByIds(ids);
  }
}
