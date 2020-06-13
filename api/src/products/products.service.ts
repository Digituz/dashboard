import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import {paginate, Pagination, IPaginationOptions} from 'nestjs-typeorm-paginate';
import { Repository } from 'typeorm';
import * as _ from 'lodash';

import { Product } from './entities/product.entity';
import { ProductDTO } from './dtos/product.dto';
import { ProductVariationDTO } from './dtos/product-variation.dto';
import { ProductVariation } from './entities/product-variation.entity';

@Injectable()
export class ProductsService {
  constructor(
    @InjectRepository(Product)
    private productsRepository: Repository<Product>,
    @InjectRepository(ProductVariation)
    private productVariationsRepository: Repository<ProductVariation>,
  ) {}

  async findAll(): Promise<Product[]> {
    return this.productsRepository.find();
  }

  async findByQuery(query: string): Promise<Product[]> {
    return this.productsRepository
      .createQueryBuilder('product')
      .where('LOWER(product.title) LIKE LOWER(:query)', {
        query: `%${query.toLowerCase()}%`,
      })
      .orWhere('LOWER(product.sku) LIKE LOWER(:query)', {
        query: `%${query.toLowerCase()}%`,
      })
      .orderBy('product.title')
      .limit(10)
      .getMany();
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
    const product = await this.findOneBySku(productDTO.sku);
    if (product) {
      return this.updateProduct(product, productDTO);
    }
    return this.productsRepository.save(productDTO);
  }

  async saveVariation(productVariationDTO: ProductVariationDTO) {
    const product = await this.findOneBySku(productVariationDTO.parentSku);
    product.productVariations = product.productVariations || [];

    // removing the previous version of the variation, if any
    _.remove(
      product.productVariations,
      pv => pv.sku === productVariationDTO.sku,
    );

    // add the new one
    product.productVariations.push({
      ...productVariationDTO,
      product: product,
    });

    // save it
    return this.productsRepository.save(product);
  }

  private async updateProduct(
    product: Product,
    productDTO: ProductDTO,
  ): Promise<Product> {
    const existingVariations = product.productVariations;
    const newVariations = productDTO.productVariations;

    // remove variations that are not part of the DTO being passed
    const excludedVariations = _.differenceBy(existingVariations, newVariations, 'sku');
    this.productVariationsRepository.remove(excludedVariations);

    return this.productsRepository.save(productDTO);
  }

  async paginate(options: IPaginationOptions): Promise<Pagination<Product>> {
    return paginate<Product>(this.productsRepository, options);
  }
}
