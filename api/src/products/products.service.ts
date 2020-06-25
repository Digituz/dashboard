import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import {
  paginate,
  Pagination,
  IPaginationOptions,
} from 'nestjs-typeorm-paginate';
import { Repository, FindConditions, FindManyOptions, Brackets } from 'typeorm';
import * as _ from 'lodash';

import { Product } from './entities/product.entity';
import { ProductDTO } from './dtos/product.dto';
import { ProductVariationDTO } from './dtos/product-variation.dto';
import { ProductVariation } from './entities/product-variation.entity';
import { IPaginationOpts } from 'src/pagination/pagination';
import { query } from 'express';

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
    return this.productsRepository.save({
      ...productDTO,
      variationsSize: productDTO.productVariations?.length,
    });
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
    const excludedVariations = _.differenceBy(
      existingVariations,
      newVariations,
      'sku',
    );
    this.productVariationsRepository.remove(excludedVariations);

    return this.productsRepository.save({
      id: product.id,
      ...productDTO,
      variationsSize: productDTO.productVariations?.length,
    });
  }

  async paginate(options: IPaginationOpts): Promise<Pagination<Product>> {
    const queryBuilder = this.productsRepository.createQueryBuilder('p');

    let orderColumn = '';

    switch (options.sortedBy?.trim()) {
      case null:
      case '':
        break;
      case 'productVariations':
        orderColumn = 'variations_size';
        break;
      case 'isActive':
        orderColumn = 'is_active';
        break;
      case 'sellingPrice':
        orderColumn = 'selling_price';
        break;
      default:
        orderColumn = options.sortedBy;
    }

    options.queryParams
      .filter(queryParam => {
        return (
          queryParam !== null &&
          queryParam.value !== null &&
          queryParam.value !== undefined
        );
      })
      .forEach(queryParam => {
        switch (queryParam.key) {
          case 'query':
            queryBuilder.andWhere(
              new Brackets(qb => {
                qb.where(`lower(p.title) like :query`, { query: `%${queryParam.value}%` })
                  .orWhere(`lower(p.sku) like :query`, { query: `%${queryParam.value}%` })
                  .orWhere(`lower(p.description) like :query`, { query: `%${queryParam.value}%` });
              }),
            );
            break;
          case 'isActive':
            queryBuilder.andWhere(`is_active = :isActive`, { isActive: queryParam.value });
            break;
          case 'withVariations':
            if (queryParam.value) {
              queryBuilder.andWhere(`variations_size > 0`);
            } else {
              queryBuilder.andWhere(`variations_size < 1`);
            }
        }
      });

    queryBuilder.orderBy(
      orderColumn,
      options.sortDirectionAscending === false ? 'DESC' : 'ASC',
    );

    const results = await paginate<Product>(queryBuilder, options);

    return new Pagination(
      await Promise.all(
        results.items.map(async (item: Product) => {
          const hydratedProduct = await this.productsRepository.findOne({
            sku: item.sku,
          });
          item.productVariations = hydratedProduct.productVariations;
          return item;
        }),
      ),
      results.meta,
      results.links,
    );
  }
}
