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

    if (!containsRealVariations) {
      variations.push({
        sku: productDTO.sku,
        description: 'Tamanho Único',
        sellingPrice: productDTO.sellingPrice,
        noVariation: true,
      });
    }

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
      withoutVariation: !containsRealVariations,
      productVariations: variations,
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

    await this.createInventories(variations);

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
    const containsRealVariations =
      productDTO.productVariations?.length > 0 ? true : false;
    const variations: ProductVariation[] = [];

    // remove variations that are not part of the DTO being passed
    const existingVariations = product.productVariations;
    const newVariationsDTO = productDTO.productVariations;
    const excludedVariations = _.differenceBy(
      existingVariations,
      newVariationsDTO,
      'sku',
    );

    await this.inventoryService.removeInventoryAndMovements(excludedVariations);
    await this.productVariationsRepository.remove(excludedVariations);

    // populate array of variations (i.e., non-DTO objects)
    if (containsRealVariations) {
      variations.push(
        ...newVariationsDTO.map(newVariationDTO => {
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
        }),
      );
    } else {
      variations.push({
        sku: productDTO.sku,
        description: 'Tamanho Único',
        sellingPrice: productDTO.sellingPrice,
        noVariation: true,
      });
    }

    // remove all images
    await this.productImagesRepository
      .createQueryBuilder()
      .delete()
      .from(ProductImage)
      .where(`product_id = ${product.id}`)
      .execute();

    // recreate images (if needed)
    if (productDTO.productImages && productDTO.productImages.length > 0) {
      const { productImages } = productDTO;
      const newImagesId = productImages.map(pI => pI.imageId);
      const newImages = await this.imagesService.findByIds(newImagesId);
      const newProductImages = productDTO.productImages.map(productImage => ({
        image: newImages.find(image => image.id === productImage.imageId),
        order: productImage.order,
        product: product,
      }));
      await this.productImagesRepository.save(newProductImages);
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
      productVariations: variations,
      variationsSize: productDTO.productVariations?.length,
      withoutVariation: !productDTO.productVariations ? true : false,
      imagesSize: productDTO.productImages?.length,
    };

    const persistedProduct = await this.productsRepository.save(updatedProduct);

    // create new inventories
    if (newVariationsDTO && newVariationsDTO.length > 0) {
      const newVariationsSKUs = newVariationsDTO.map(v => v.sku);
      await this.createInventories(
        variations.filter(v => newVariationsSKUs.includes(v.sku)),
      );
    }

    return Promise.resolve(persistedProduct);
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
