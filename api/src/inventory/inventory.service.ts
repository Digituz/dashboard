import { Injectable } from '@nestjs/common';
import { Pagination, paginate } from 'nestjs-typeorm-paginate';
import { minBy } from 'lodash';

import { Inventory } from './inventory.entity';
import { InventoryMovement } from './inventory-movement.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, Brackets, In } from 'typeorm';
import { IPaginationOpts } from '../pagination/pagination';
import { InventoryMovementDTO } from './inventory-movement.dto';
import { SaleOrder } from '../sales-order/entities/sale-order.entity';
import { ProductVariation } from '../products/entities/product-variation.entity';
import { Product } from '../products/entities/product.entity';
import { ProductComposition } from '../products/entities/product-composition.entity';

@Injectable()
export class InventoryService {
  constructor(
    @InjectRepository(Inventory)
    private inventoryRepository: Repository<Inventory>,
    @InjectRepository(InventoryMovement)
    private inventoryMovementRepository: Repository<InventoryMovement>,
    @InjectRepository(Product)
    private productRepository: Repository<Product>,
    @InjectRepository(ProductVariation)
    private productVariationRepository: Repository<ProductVariation>,
    @InjectRepository(ProductComposition)
    private productCompositionRepository: Repository<ProductComposition>,
  ) {}

  async paginate(options: IPaginationOpts): Promise<Pagination<Inventory>> {
    const queryBuilder = this.inventoryRepository.createQueryBuilder('i');

    queryBuilder
      .leftJoinAndSelect('i.productVariation', 'pv')
      .leftJoinAndSelect('pv.product', 'p');

    let orderColumn = '';

    switch (options.sortedBy?.trim()) {
      case undefined:
      case null:
      case 'sku':
        orderColumn = 'pv.sku';
        break;
      case 'currentPosition':
        orderColumn = 'i.currentPosition';
        break;
      case 'title':
        orderColumn = 'p.title';
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
                qb.where(`lower(pv.sku) like :query`, {
                  query: `%${queryParam.value.toString().toLowerCase()}%`,
                });
              }),
            );
            break;
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

    return paginate<Inventory>(queryBuilder, options);
  }

  findById(id: number): Promise<Inventory> {
    return this.inventoryRepository.findOne(id);
  }

  findByVariationIds(ids: number[]): Promise<Inventory[]> {
    return this.inventoryRepository.find({
      productVariation: In(ids),
    });
  }

  findBySku(sku: string): Promise<Inventory> {
    return this.inventoryRepository
      .createQueryBuilder('i')
      .leftJoinAndSelect('i.productVariation', 'p')
      .where('p.sku = :sku', { sku })
      .getOne();
  }

  async cleanUpMovements(saleOrder: SaleOrder) {
    const movements = await this.inventoryMovementRepository.find({
      saleOrder: saleOrder,
    });
    const removeMovementJobs = movements.map(movement => {
      return new Promise(async res => {
        const inventory = movement.inventory;
        inventory.currentPosition -= movement.amount;
        await this.inventoryRepository.save(inventory);
        await this.inventoryMovementRepository.delete(movement.id);
        res();
      });
    });
    await Promise.all(removeMovementJobs);
  }

  async removeInventoryAndMovements(productVariations: ProductVariation[]) {
    const removeJobs = productVariations.map(productVariation => {
      return new Promise(async res => {
        const inventory = await this.inventoryRepository.findOne({
          where: { productVariation },
        });
        await this.inventoryMovementRepository
          .createQueryBuilder()
          .delete()
          .from(InventoryMovement)
          .where(`inventory_id = ${inventory.id}`)
          .execute();
        await this.inventoryRepository.delete(inventory);
        res();
      });
    });
    await Promise.all(removeJobs);
  }

  async saveMovement(
    inventoryMovementDTO: InventoryMovementDTO,
    saleOrder?: SaleOrder,
  ): Promise<InventoryMovement> {
    const inventory = await this.findBySku(inventoryMovementDTO.sku);

    // updating inventory current position
    inventory.currentPosition += inventoryMovementDTO.amount;
    await this.inventoryRepository.save(inventory);

    // updating product variation current position
    await this.productVariationRepository.update(
      {
        sku: inventoryMovementDTO.sku,
      },
      {
        currentPosition: inventory.currentPosition,
      },
    );

    const movement: InventoryMovement = {
      inventory,
      amount: inventoryMovementDTO.amount,
      description: inventoryMovementDTO.description,
      saleOrder: saleOrder,
    };

    const inventoryMovement = await this.inventoryMovementRepository.save(
      movement,
    );

    const dependentProducts: Product[] = await this.productRepository
      .createQueryBuilder('p')
      .leftJoinAndSelect('p.productComposition', 'pc')
      .leftJoinAndSelect('p.productVariations', 'pv')
      .where('pc.productVariation = :productVariation', {
        productVariation: inventory.productVariation.id,
      })
      .getMany();

    if (dependentProducts && dependentProducts.length > 0) {
      // This scenario means that there are composite products that use the product variation
      // being moved. As such, we might need to update their inventory to reflect the new reality.
      const updateCompositionJobs = dependentProducts.map(
        async (dependentProduct: Product) => {
          await this.updateProductCompositionInventories(
            dependentProduct,
            saleOrder,
            inventoryMovementDTO.description,
          );
        },
      );
      await Promise.all(updateCompositionJobs);
    }

    return inventoryMovement;
  }

  private async updateProductCompositionInventories(
    product: Product,
    saleOrder: SaleOrder,
    description: string,
  ) {
    // step 1: find the variations
    const composition = await this.productCompositionRepository
      .createQueryBuilder('pc')
      .leftJoinAndSelect('pc.productVariation', 'pv')
      .where('pc.product = :productId', { productId: product.id })
      .getMany();
    const parts = composition.map(pc => pc.productVariation);

    // step 2: check the min inventory of these parts
    const minInventory = minBy(parts, part => part.currentPosition);

    // step 3: calc the amount to be updated
    const amountMoved =
      minInventory.currentPosition -
      product.productVariations[0].currentPosition;

    if (amountMoved === 0) return; // no change, abort

    const productCompositionInventory = await this.inventoryRepository.findOneOrFail(
      {
        productVariation: product.productVariations[0],
      },
    );

    const inventoryMovement: InventoryMovement = {
      inventory: productCompositionInventory,
      saleOrder,
      description,
      amount:
        minInventory.currentPosition -
        productCompositionInventory.currentPosition,
    };

    // updating product variation current position
    await this.productVariationRepository.update(
      {
        sku: product.productVariations[0].sku,
      },
      {
        currentPosition:
          product.productVariations[0].currentPosition +
          inventoryMovement.amount,
      },
    );

    return this.inventoryMovementRepository.save(inventoryMovement);
  }

  save(inventory: Inventory): Promise<Inventory> {
    return this.inventoryRepository.save(inventory);
  }
}
