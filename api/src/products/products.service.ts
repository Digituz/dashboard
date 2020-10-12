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
import { ProductCategory } from './entities/product-category.enum';
import { ProductComposition } from './entities/product-composition.entity';
import { minBy } from 'lodash';

@Injectable()
export class ProductsService {
  constructor(
    @InjectRepository(Product)
    private productsRepository: Repository<Product>,
    @InjectRepository(ProductVariation)
    private productVariationsRepository: Repository<ProductVariation>,
    @InjectRepository(ProductImage)
    private productImagesRepository: Repository<ProductImage>,
    @InjectRepository(ProductComposition)
    private productCompositionRepository: Repository<ProductComposition>,
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

    const productVariations: ProductVariation[] = products.reduce(
      (variations, product) => {
        variations.push(...product.productVariations);
        return variations;
      },
      [],
    );

    for (const variation of productVariations) {
      const inventory = await this.inventoryService.findBySku(variation.sku);
      variation.currentPosition = inventory.currentPosition;
    }
    return Promise.resolve(products);
  }

  async findByQuery(query: string): Promise<Product[]> {
    return this.productsRepository
      .createQueryBuilder('product')
      .where('lower(product.title) like lower(:query)', {
        query: `%${query}%`,
      })
      .orWhere('lower(product.sku) like lower(:query)', {
        query: `%${query}%`,
      })
      .orderBy('product.title')
      .limit(10)
      .getMany();
  }

  async findVariationsBySkus(skus: string[]): Promise<ProductVariation[]> {
    return this.productVariationsRepository.find({
      where: {
        sku: In(skus),
      },
      relations: ['product'],
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

    product.productComposition = await this.productCompositionRepository
      .createQueryBuilder('pc')
      .leftJoinAndSelect('pc.productVariation', 'pv')
      .leftJoinAndSelect('pv.product', 'p')
      .where({ product })
      .getMany();

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
    const variations: ProductVariation[] = productDTO.productVariations || [];

    const sortedByMinimumPrice = productDTO.productVariations.sort(
      (p1, p2) => p1.sellingPrice - p2.sellingPrice,
    );
    const sellingPrice = sortedByMinimumPrice[0].sellingPrice;

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
      category: productDTO.category
        ? ProductCategory[productDTO.category]
        : null,
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

    await this.persistProductComposition(productDTO, persistedProduct);

    return persistedProduct;
  }

  private async persistProductComposition(
    productDTO: ProductDTO,
    persistedProduct: Product,
  ) {
    if (
      !productDTO.productComposition ||
      productDTO.productComposition.length === 0
    ) {
      return;
    }

    const productVariations = await this.productVariationsRepository.find({
      sku: In(productDTO.productComposition),
    });

    // TODO test situations that prevent users from adding a product composition
    // that point to its own product variation
    const belongsToCurrentProduct = productVariations.find(
      variation => variation.product === persistedProduct,
    );
    if (belongsToCurrentProduct) {
      throw new Error(
        'Composite product cannot use variations that belong to itself.',
      );
    }

    const productCompositions: ProductComposition[] = productVariations.map(
      variation => ({
        product: persistedProduct,
        productVariation: variation,
      }),
    );
    const composition = await this.productCompositionRepository.save(
      productCompositions,
    );
    persistedProduct.productComposition = composition.map(comp => {
      delete comp.product;
      return comp;
    });

    const inventories = await this.inventoryService.findByVariationIds(
      productVariations.map(pv => pv.id),
    );

    const minInventoryVariation = minBy(inventories, 'currentPosition');
    await this.inventoryService.saveMovement(
      {
        sku: persistedProduct.sku,
        amount: minInventoryVariation.currentPosition,
        description: 'Criação do produto composto.',
      },
      null,
      true,
    );
  }

  async updateVariationProperty(
    id: number,
    properties: Partial<ProductVariation>,
  ) {
    return this.productVariationsRepository.update(id, properties);
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

    const variationsToBeUpdated = _.differenceBy(
      newVariations,
      variationsToBeInserted,
      'sku',
    );

    if (variationsToBeUpdated) {
      const newVersions = variationsToBeUpdated.map(variation => {
        const oldVersion = oldVariations.find(o => o.sku === variation.sku);
        variation.product = product;
        return {
          ...oldVersion,
          ...variation,
        };
      });
      await this.productVariationsRepository.save(newVersions);
    }

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
    // perform some initial validation
    if (
      !productDTO.productVariations ||
      productDTO.productVariations.length === 0
    ) {
      throw new Error('Products must have at least one variation.');
    }

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

  async updateProductProperties(
    productId: number,
    properties: Partial<Product>,
  ) {
    return this.productsRepository.update({ id: productId }, properties);
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
      imagesSize: productDTO.productImages?.length,
      category: productDTO.category
        ? ProductCategory[productDTO.category]
        : null,
    };

    const persistedProduct = await this.productsRepository.save(updatedProduct);

    // managing variations and inventories
    const previousVariations = previousProductVersion.productVariations;

    await this.updateVariations(
      persistedProduct,
      productDTO.productVariations,
      previousVariations,
    );

    if (
      (productDTO.productComposition &&
        productDTO.productComposition.length > 0) ||
      (previousProductVersion.productComposition &&
        previousProductVersion.productComposition.length > 0)
    ) {
      // 1. clean up product compositions (we add again later)
      await this.productCompositionRepository.delete({
        product: previousProductVersion,
      });

      // 2. set current position to zero (it will set the correct value later)
      this.productVariationsRepository.update(
        {
          sku: productDTO.sku,
        },
        {
          currentPosition: 0,
        },
      );

      await this.inventoryService.eraseCurrentPosition(productDTO.sku);

      // 3. persist the compositions again
      await this.persistProductComposition(productDTO, persistedProduct);
    }

    return Promise.resolve(persistedProduct);
  }

  async findVariations(query: string): Promise<ProductVariationDetailsDTO[]> {
    const queryBuilder = this.productVariationsRepository
      .createQueryBuilder('pV')
      .leftJoinAndSelect('pV.product', 'p')
      .where('lower(p.sku) like lower(:query)', {
        query: `%${query}%`,
      })
      .orWhere('lower(pV.sku) like lower(:query)', {
        query: `%${query}%`,
      })
      .orWhere('lower(p.title) like lower(:query)', {
        query: `%${query}%`,
      })
      .orWhere('lower(pV.description) like lower(:query)', {
        query: `%${query}%`,
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
          currentPosition: productVariation.currentPosition,
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
                qb.where(`lower(p.title) like lower(:query)`, {
                  query: `%${queryParam.value}%`,
                })
                  .orWhere(`lower(p.sku) like lower(:query)`, {
                    query: `%${queryParam.value}%`,
                  })
                  .orWhere(`lower(p.description) like lower(:query)`, {
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
              queryBuilder.andWhere(`variations_size > 1`);
            } else {
              queryBuilder.andWhere(`variations_size < 2`);
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
