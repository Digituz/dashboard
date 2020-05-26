import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Product } from './entities/product.entity';
import { CreateProductDTO } from './dtos/create-product.dto';
import { CreateProductVariationDTO } from './dtos/create-product-variation.dto';

@Injectable()
export class ProductsService {
  constructor(
    @InjectRepository(Product)
    private productsRepository: Repository<Product>,
  ) {}

  async findAll(): Promise<Product[]> {
    return this.productsRepository.find();
  }

  async findOne(id: number): Promise<Product> {
    return this.productsRepository.findOne(id);
  }

  async findOneBySku(sku: string): Promise<Product> {
    return this.productsRepository.findOne({
      sku,
    });
  }

  async remove(id: number): Promise<void> {
    await this.productsRepository.delete(id);
  }

  async save(createProductDTO: CreateProductDTO): Promise<Product> {
    return this.productsRepository.save(createProductDTO);
  }

  async addVariation(
    parentSku: string,
    createProductDTO: CreateProductVariationDTO,
  ) {
    const product = await this.findOneBySku(parentSku);
    createProductDTO.product = product;
    product.productVariations = product.productVariations || [];
    product.productVariations.push(createProductDTO);
    await this.save(product);
  }
}
