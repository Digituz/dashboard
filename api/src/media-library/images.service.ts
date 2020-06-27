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

  async findAll(): Promise<Image[]> {
    return this.imagesRepository.find();
  }

  async findById(id: number) {
    // return this.imagesRepository.findOne(id);
    return this.imagesRepository
      .createQueryBuilder('image')
      .leftJoinAndSelect('image.tags', 'tags')
      .where('image.id = :id', { id })
      .getOne();
  }
}
