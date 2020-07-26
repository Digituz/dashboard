import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { paginate, Pagination } from 'nestjs-typeorm-paginate';
import { Repository, Brackets, In } from 'typeorm';
import * as _ from 'lodash';

import { Product } from './entities/product.entity';
import { ProductDTO } from './dtos/product.dto';
import { ProductImage } from './entities/product-image.entity';
import { ProductVariation } from './entities/product-variation.entity';
import { IPaginationOpts } from '../pagination/pagination';
import { TagsService } from '../tags/tags.service';
import { ImagesService } from '../media-library/images.service';
import { Inventory } from '../inventory/inventory.entity';
import { InventoryService } from '../inventory/inventory.service';
import { ProductVariationDetailsDTO } from './dtos/product-variation-details.dto';

@Injectable()
export class ProductsService {
  constructor(
    @InjectRepository(Product)
    private productsRepository: Repository<Product>,
    @InjectRepository(ProductVariation)
    private productVariationsRepository: Repository<ProductVariation>,
    @InjectRepository(ProductImage)
    private productImagesRepository: Repository<ProductImage>,
    private inventoryService: InventoryService,
    private imagesService: ImagesService,
    private tagsService: TagsService,
  ) {}

  async findAll(): Promise<Product[]> {
    const products = await this.productsRepository
      .createQueryBuilder('product')
      .leftJoinAndSelect('product.productVariations', 'pv')
      .leftJoinAndSelect('product.productImages', 'pi')
      .leftJoinAndSelect('pi.image', 'i')
      .getMany();

    const productVariations: ProductVariation[] = products.reduce((variations, product) => {
      variations.push(...product.productVariations);
      return variations;
    }, []);

    for (const variation of productVariations) {
      const inventory = await this.inventoryService.findBySku(variation.sku);
      variation.currentPosition = inventory.currentPosition;
    }
    return Promise.resolve(products);
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

  async findVariationsBySkus(skus: string[]): Promise<ProductVariation[]> {
    return this.productVariationsRepository.find({
      sku: In(skus),
    });
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

    product.productImages = product.productImages.sort((a, b) => {
      return a.order - b.order;
    });

    return product;
  }

  async remove(id: number): Promise<void> {
    await this.productsRepository.delete(id);
  }

  async createInventories(variations: ProductVariation[]) {
    // starting the inventory info
    const inventoryCreationJob = variations.map(variation => {
      return new Promise(async res => {
        const inventory: Inventory = {
          productVariation: variation,
          currentPosition: 0,
          movements: [],
        };
        await this.inventoryService.save(inventory);
        res();
      });
    });

    await Promise.all(inventoryCreationJob);
  }

  private async insertProduct(productDTO: ProductDTO) {
    const containsRealVariations =
      productDTO.productVariations?.length > 0 ? true : false;
    const variations: ProductVariation[] = productDTO.productVariations || [];

    let sellingPrice;
    if (!containsRealVariations) {
      variations.push({
        sku: productDTO.sku,
        description: 'Tamanho Único',
        sellingPrice: productDTO.sellingPrice,
        noVariation: true,
      });

      sellingPrice = productDTO.sellingPrice;
    } else {
      const sortedByMinimumPrice = productDTO.productVariations.sort(
        (p1, p2) => p1.sellingPrice - p2.sellingPrice,
      );
      sellingPrice = sortedByMinimumPrice[0].sellingPrice;
    }

    const newProduct: Product = {
      sku: productDTO.sku,
      title: productDTO.title,
      ncm: productDTO.ncm,
      description: productDTO.description,
      productDetails: productDTO.productDetails,
      sellingPrice: sellingPrice,
      height: productDTO.height,
      width: productDTO.width,
      length: productDTO.length,
      weight: productDTO.weight,
      isActive: productDTO.isActive,
      variationsSize: productDTO.productVariations?.length,
      imagesSize: productDTO.productImages?.length,
      withoutVariation: !containsRealVariations,
    };

    const persistedProduct = await this.productsRepository.save(newProduct);

    // inserting variations
    const insertVariationJobs = variations.map(variation => {
      return new Promise(async res => {
        variation.product = persistedProduct;
        await this.productVariationsRepository.save(variation);
        res();
      });
    });
    await Promise.all(insertVariationJobs);

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

    await this.createInventories(variations);

    return persistedProduct;
  }

  private async updateVariations(
    product: Product,
    newVariations: ProductVariation[] = [],
    oldVariations: ProductVariation[] = [],
  ) {
    const variationsToBeInserted = _.differenceBy(
      newVariations,
      oldVariations,
      'sku',
    );
    const variationsToBeRemoved = _.differenceBy(
      oldVariations,
      newVariations,
      'sku',
    );

    if (variationsToBeRemoved.length > 0) {
      await this.inventoryService.removeInventoryAndMovements(
        variationsToBeRemoved,
      );
      await this.productVariationsRepository.remove(variationsToBeRemoved);
    }

    if (variationsToBeInserted) {
      variationsToBeInserted.forEach(variation => {
        variation.product = product;
      });
      const persistedVariations = await this.productVariationsRepository.save(
        variationsToBeInserted,
      );
      await this.createInventories(persistedVariations);
    }
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
    previousProductVersion: Product,
    productDTO: ProductDTO,
  ): Promise<Product> {
    // remove all images
    await this.productImagesRepository
      .createQueryBuilder()
      .delete()
      .from(ProductImage)
      .where(`product_id = ${previousProductVersion.id}`)
      .execute();

    // recreate images (if needed)
    if (productDTO.productImages && productDTO.productImages.length > 0) {
      const { productImages } = productDTO;
      const newImagesId = productImages.map(pI => pI.imageId);
      const newImages = await this.imagesService.findByIds(newImagesId);
      const newProductImages = productDTO.productImages.map(productImage => ({
        image: newImages.find(image => image.id === productImage.imageId),
        order: productImage.order,
        product: previousProductVersion,
      }));
      await this.productImagesRepository.save(newProductImages);
    }

    let sellingPrice;
    if (
      productDTO.productVariations &&
      productDTO.productVariations.length > 0
    ) {
      const sortedByMinimumPrice = productDTO.productVariations.sort(
        (p1, p2) => p1.sellingPrice - p2.sellingPrice,
      );
      sellingPrice = sortedByMinimumPrice[0].sellingPrice;
    } else {
      sellingPrice = productDTO.sellingPrice || null;
    }

    // instantiate new product object (i.e., non-DTO)
    const updatedProduct: Product = {
      id: previousProductVersion.id,
      sku: productDTO.sku,
      title: productDTO.title,
      description: productDTO.description,
      productDetails: productDTO.productDetails,
      sellingPrice: sellingPrice,
      height: productDTO.height,
      width: productDTO.width,
      length: productDTO.length,
      weight: productDTO.weight,
      isActive: productDTO.isActive,
      ncm: productDTO.ncm,
      variationsSize: productDTO.productVariations?.length,
      withoutVariation: !productDTO.productVariations ? true : false,
      imagesSize: productDTO.productImages?.length,
    };

    const persistedProduct = await this.productsRepository.save(updatedProduct);

    // managing variations and inventories
    const previousVariations = previousProductVersion.productVariations;
    if (
      !previousProductVersion.withoutVariation &&
      persistedProduct.withoutVariation
    ) {
      const newVariations = [
        {
          sku: productDTO.sku,
          description: 'Tamanho Único',
          sellingPrice: productDTO.sellingPrice,
          noVariation: true,
        },
      ];
      await this.updateVariations(
        persistedProduct,
        newVariations,
        previousVariations,
      );
    } else if (!persistedProduct.withoutVariation) {
      await this.updateVariations(
        persistedProduct,
        productDTO.productVariations,
        previousVariations,
      );
    }

    return Promise.resolve(persistedProduct);
  }

  async findVariations(query: string): Promise<ProductVariationDetailsDTO[]> {
    const queryBuilder = this.productVariationsRepository
      .createQueryBuilder('pV')
      .leftJoinAndSelect('pV.product', 'p')
      .where('lower(p.sku) like :query', {
        query: `%${query.toLowerCase()}%`,
      })
      .orWhere('lower(pV.sku) like :query', {
        query: `%${query.toLowerCase()}%`,
      })
      .orWhere('lower(p.title) like :query', {
        query: `%${query.toLowerCase()}%`,
      })
      .orWhere('lower(pV.description) like :query', {
        query: `%${query.toLowerCase()}%`,
      })
      .orderBy('p.title')
      .orderBy('pV.sku')
      .orderBy('pV.description')
      .limit(10);

    const productVariations: ProductVariation[] = await queryBuilder.getMany();

    return Promise.resolve(
      productVariations.map(productVariation => {
        return {
          parentSku: productVariation.product.sku,
          title: productVariation.product.title,
          sku: productVariation.sku,
          description: productVariation.description,
          sellingPrice: productVariation.sellingPrice,
          noVariation: productVariation.product.withoutVariation,
        };
      }),
    );
  }

  async paginate(options: IPaginationOpts): Promise<Pagination<Product>> {
    const queryBuilder = this.productsRepository.createQueryBuilder('p');

    let orderColumn = '';

    switch (options.sortedBy?.trim()) {
      case undefined:
      case null:
      case '':
        orderColumn = 'title';
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

    let sortDirection;
    let sortNulls;
    switch (options.sortDirectionAscending) {
      case undefined:
      case null:
      case true:
        sortDirection = 'ASC';
        sortNulls = 'NULLS FIRST';
        break;
      default:
        sortDirection = 'DESC';
        sortNulls = 'NULLS LAST';
    }

    queryBuilder.orderBy(orderColumn, sortDirection, sortNulls);

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
