import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Product } from './entities/product.entity';
import { CreateProductDTO } from './dtos/create-product.dto';

@Injectable()
export class ProductsService {
  constructor(
    @InjectRepository(Product)
    private productsRepository: Repository<Product>,
  ) {}

  findAll(): Promise<Product[]> {
    return this.productsRepository.find();
  }

  findOne(id: string): Promise<Product> {
    return this.productsRepository.findOne(id);
  }

  async remove(id: string): Promise<void> {
    await this.productsRepository.delete(id);
  }

  save(createProductDTO: CreateProductDTO): Promise<Product> {
    return this.productsRepository.save(createProductDTO);
  }
}
