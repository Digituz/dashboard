import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Product } from './entities/product.entity';
import { ProductDTO } from './dtos/product.dto';
import { ProductVariationDTO } from './dtos/product-variation.dto';

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

  async save(productDTO: ProductDTO): Promise<Product> {
    return this.productsRepository.save(productDTO);
  }

  async saveVariation(productVariationDTO: ProductVariationDTO) {
    const product = await this.findOneBySku(productVariationDTO.parentSku);
    product.productVariations = product.productVariations || [];
    product.productVariations.push({
      ...productVariationDTO,
      product: product,
    });
    await this.save(product);
  }
}
