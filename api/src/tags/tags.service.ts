import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, In, InsertResult } from 'typeorm';
import { Tag } from './tag.entity';

@Injectable()
export class TagsService {
  constructor(
    @InjectRepository(Tag)
    private tagsRepository: Repository<Tag>,
  ) {}

  async save(tag: Tag): Promise<InsertResult> {
    return this.tagsRepository
      .createQueryBuilder()
      .insert()
      .into(Tag)
      .values(tag)
      .onConflict('("label") DO NOTHING')
      .execute();
  }

  async query(query: string): Promise<Tag[]> {
    return this.tagsRepository
      .createQueryBuilder('tag')
      .where('lower(tag.label) like lower(:query)', { query: `%${query}%` })
      .orWhere('lower(tag.description) like lower(:query)', {
        query: `%${query}%`,
      })
      .limit(10)
      .getMany();
  }

  async findByLabels(labels: string[]): Promise<Tag[]> {
    return this.tagsRepository.find({
      where: { label: In(labels) },
      order: { description: 'ASC' },
    });
  }
}
