import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';

import { Image } from './image.entity';

@Injectable()
export class ImagesService {
  constructor(
    @InjectRepository(Image)
    private imagesRepository: Repository<Image>,
  ) {}

  async save(image: Image): Promise<Image> {
    return this.imagesRepository.save(image);
  }

  async findAll(archived = false): Promise<Image[]> {
    return this.imagesRepository.find({
      where: { archived },
    });
  }

  async findById(id: number): Promise<Image> {
    // return this.imagesRepository.findOne(id);
    return this.imagesRepository
      .createQueryBuilder('image')
      .leftJoinAndSelect('image.tags', 'tags')
      .where('image.id = :id', { id })
      .getOne();
  }

  findAllWithTag(tagLabel: string): Promise<Image[]> {
    return this.imagesRepository
      .createQueryBuilder('image')
      .leftJoin('image.tags', 'tag')
      .where('tag.label = :label', { label: tagLabel })
      .getMany();
  }
}
