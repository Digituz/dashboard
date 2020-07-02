import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { paginate, Pagination } from 'nestjs-typeorm-paginate';
import { Repository, Brackets } from 'typeorm';
import * as _ from 'lodash';

import { Product } from './entities/product.entity';
import { ProductDTO } from './dtos/product.dto';
import { ProductImage } from './entities/product-image.entity';
import { ProductVariation } from './entities/product-variation.entity';
import { IPaginationOpts } from '../pagination/pagination';
import { TagsService } from '../tags/tags.service';
import { ImagesService } from '../media-library/images.service';

@Injectable()
export class ProductsService {
  constructor(
    @InjectRepository(Product)
    private productsRepository: Repository<Product>,
    @InjectRepository(ProductVariation)
    private productVariationsRepository: Repository<ProductVariation>,
    @InjectRepository(ProductImage)
    private productImagesRepository: Repository<ProductImage>,
    private imagesService: ImagesService,
    private tagsService: TagsService,
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
    const product = await this.productsRepository.findOne({
      sku,
    });

    if (!product) return null;

    product.productImages = await this.productImagesRepository.find({
      where: { product: product },
    });

    return product;
  }

  async remove(id: number): Promise<void> {
    await this.productsRepository.delete(id);
  }

  private async insertProduct(productDTO: ProductDTO) {
    const newProduct: Product = {
      sku: productDTO.sku,
      title: productDTO.title,
      ncm: productDTO.ncm,
      description: productDTO.description,
      productDetails: productDTO.productDetails,
      sellingPrice: productDTO.sellingPrice,
      height: productDTO.height,
      width: productDTO.width,
      length: productDTO.length,
      weight: productDTO.weight,
      isActive: productDTO.isActive,
      variationsSize: productDTO.productVariations?.length,
      imagesSize: productDTO.productImages?.length,
      productVariations: productDTO.productVariations,
    };

    const persistedProduct = await this.productsRepository.save(newProduct);

    // managing product images
    const imagesIds =
      productDTO.productImages?.map(productImage => productImage.imageId) || [];
    const images = await this.imagesService.findByIds(imagesIds);
    const productImages = productDTO.productImages?.map(productImage => ({
      image: images.find(image => image.id === productImage.imageId),
      order: productImage.order,
      product: persistedProduct,
    }));
    if (productImages) {
      await this.productImagesRepository.save(productImages);
    }

    return persistedProduct;
  }

  async save(productDTO: ProductDTO): Promise<Product> {
    let product = await this.findOneBySku(productDTO.sku);
    if (product) {
      product = await this.updateProduct(product, productDTO);
    } else {
      product = await this.insertProduct(productDTO);
    }
    this.tagsService.save({
      label: product.sku,
      description: product.title,
    });
    return Promise.resolve(product);
  }

  private async updateProduct(
    product: Product,
    productDTO: ProductDTO,
  ): Promise<Product> {
    // remove variations that are not part of the DTO being passed
    const existingVariations = product.productVariations;
    const newVariationsDTO = productDTO.productVariations;
    const excludedVariations = _.differenceBy(
      existingVariations,
      newVariationsDTO,
      'sku',
    );

    await this.productVariationsRepository.remove(excludedVariations);

    // instantiate array of variations (i.e., non-DTO objects)
    const newVariations: ProductVariation[] =
      newVariationsDTO?.map(newVariationDTO => {
        const previousVariaton = existingVariations.find(
          v => v.sku === newVariationDTO.sku,
        );
        return {
          ...previousVariaton,
          product: product,
          sku: newVariationDTO.sku,
          sellingPrice: newVariationDTO.sellingPrice,
          description: newVariationDTO.description,
        };
      }) || [];

    // remove images that are not part of the DTO being passed
    const existingImages = product.productImages;
    const newImagesDTO = productDTO.productImages;
    const newImagesId =
      newImagesDTO?.map(productImageDTO => productImageDTO.imageId) || [];
    const excludedImages =
      existingImages?.filter(productImage => {
        return !newImagesId.includes(productImage.image.id);
      }) || [];

    if (excludedImages && excludedImages.length > 0) {
      const excludedImagesIds = excludedImages
        .map(excludedImage => excludedImage.image.id)
        .join(',');

      await this.productImagesRepository
        .createQueryBuilder()
        .delete()
        .from(ProductImage)
        .where(
          `product_id = ${product.id} and image_id in (${excludedImagesIds})`,
        )
        .execute();
    }

    if (newImagesId && newImagesId.length > 0) {
      const newImages = await this.imagesService.findByIds(newImagesId);
      const productImages = productDTO.productImages
        .filter(productImage => newImagesId.includes(productImage.imageId))
        .map(productImage => ({
          image: newImages.find(image => image.id === productImage.imageId),
          order: productImage.order,
          product: product,
        }));
      await this.productImagesRepository.save(productImages);
    }

    // instantiate new product object (i.e., non-DTO)
    const updatedProduct: Product = {
      id: product.id,
      sku: productDTO.sku,
      title: productDTO.title,
      description: productDTO.description,
      productDetails: productDTO.productDetails,
      sellingPrice: productDTO.sellingPrice,
      height: productDTO.height,
      width: productDTO.width,
      length: productDTO.length,
      weight: productDTO.weight,
      isActive: productDTO.isActive,
      ncm: productDTO.ncm,
      productVariations: newVariations,
      variationsSize: productDTO.productVariations?.length,
      imagesSize: productDTO.productImages?.length,
    };

    return this.productsRepository.save(updatedProduct);
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
      case 'productImages':
        orderColumn = 'images_size';
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
                qb.where(`lower(p.title) like :query`, {
                  query: `%${queryParam.value}%`,
                })
                  .orWhere(`lower(p.sku) like :query`, {
                    query: `%${queryParam.value}%`,
                  })
                  .orWhere(`lower(p.description) like :query`, {
                    query: `%${queryParam.value}%`,
                  });
              }),
            );
            break;
          case 'isActive':
            queryBuilder.andWhere(`is_active = :isActive`, {
              isActive: queryParam.value,
            });
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
          item.productImages = hydratedProduct.productImages;
          return item;
        }),
      ),
      results.meta,
      results.links,
    );
  }
}
