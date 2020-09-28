import { Injectable } from '@nestjs/common';
import { Pagination, paginate } from 'nestjs-typeorm-paginate';
import { minBy } from 'lodash';

import * as XLSX from 'xlsx';

import { Inventory } from './inventory.entity';
import { InventoryMovement } from './inventory-movement.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, Brackets, In, Binary } from 'typeorm';
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
      .filter((queryParam) => {
        return (
          queryParam !== null &&
          queryParam.value !== null &&
          queryParam.value !== undefined
        );
      })
      .forEach((queryParam) => {
        switch (queryParam.key) {
          case 'query':
            queryBuilder.andWhere(
              new Brackets((qb) => {
                qb.where(`lower(pv.sku) like lower(:query)`, {
                  query: `%${queryParam.value.toString()}%`,
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
    return this.inventoryRepository
      .createQueryBuilder('i')
      .leftJoinAndSelect('i.movements', 'm')
      .leftJoinAndSelect('i.productVariation', 'pv')
      .leftJoinAndSelect('pv.product', 'p')
      .where({ id })
      .getOne();
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
    const removeMovementJobs = movements.map((movement) => {
      return new Promise(async (res) => {
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
    const removeJobs = productVariations.map((productVariation) => {
      return new Promise(async (res) => {
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
    allowPositiveMovementForCompositeProducts?: boolean,
  ): Promise<InventoryMovement> {
    // 1. check if this is a composite product
    if (
      !allowPositiveMovementForCompositeProducts &&
      inventoryMovementDTO.amount > 0
    ) {
      const product = await this.productRepository
        .createQueryBuilder('p')
        .leftJoin('p.productVariations', 'pv')
        .leftJoinAndSelect('p.productComposition', 'pc')
        .where('pv.sku = :sku', {
          sku: inventoryMovementDTO.sku,
        })
        .getOne();

      if (product.productComposition.length > 0) {
        throw new Error('Cannot increase inventory for composite produts');
      }
    }

    // 2. update product position and persist movement
    const inventoryMovement = await this.moveProduct(
      inventoryMovementDTO,
      saleOrder,
    );

    // 3. if this product is part of compositions, update them
    await this.updateDependentProducts(
      inventoryMovement.inventory,
      saleOrder,
      inventoryMovementDTO,
    );

    // 4. if this product is a composite product, update its parts
    await this.updatePartsOfComposition(inventoryMovementDTO, saleOrder);
    return inventoryMovement;
  }

  private async moveProduct(
    inventoryMovementDTO: InventoryMovementDTO,
    saleOrder: SaleOrder,
  ) {
    const inventory = await this.findBySku(inventoryMovementDTO.sku);

    // 1. updating inventory current position
    inventory.currentPosition += inventoryMovementDTO.amount;
    await this.inventoryRepository.save(inventory);

    // 2. updating product variation current position
    await this.productVariationRepository.update(
      {
        sku: inventoryMovementDTO.sku,
      },
      {
        currentPosition: inventory.currentPosition,
      },
    );

    // 3. persist movement
    const movement: InventoryMovement = {
      inventory,
      amount: inventoryMovementDTO.amount,
      description: inventoryMovementDTO.description,
      saleOrder: saleOrder,
    };

    return await this.inventoryMovementRepository.save(movement);
  }

  private async updatePartsOfComposition(
    inventoryMovementDTO: InventoryMovementDTO,
    saleOrder: SaleOrder,
  ) {
    if (inventoryMovementDTO.amount > 0) {
      // the thing is, too add items to composite products, one must add through its parts
      return;
    }

    const productCompositions: ProductComposition[] = await this.productCompositionRepository
      .createQueryBuilder('pc')
      .leftJoinAndSelect('pc.productVariation', 'pv')
      .leftJoin('pc.product', 'p')
      .where('p.sku = :sku', { sku: inventoryMovementDTO.sku })
      .getMany();

    if (!productCompositions || productCompositions.length === 0) return;

    const partsOfComposition: ProductVariation[] = productCompositions.map(
      (pc) => pc.productVariation,
    );

    await Promise.all(
      partsOfComposition.map(async (part) => {
        const movement: InventoryMovementDTO = {
          ...inventoryMovementDTO,
          sku: part.sku,
        };
        await this.moveProduct(movement, saleOrder);
      }),
    );
  }

  private async updateDependentProducts(
    inventory: Inventory,
    saleOrder: SaleOrder,
    inventoryMovementDTO: InventoryMovementDTO,
  ) {
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
    const parts = composition.map((pc) => pc.productVariation);

    // step 2: check the min inventory of these parts
    const minInventory = minBy(parts, (part) => part.currentPosition);

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

    const inventoryMovementDTO: InventoryMovementDTO = {
      sku: product.sku,
      amount:
        minInventory.currentPosition -
        productCompositionInventory.currentPosition,
      description: description,
    };

    return await this.moveProduct(inventoryMovementDTO, saleOrder);
  }

  save(inventory: Inventory): Promise<Inventory> {
    return this.inventoryRepository.save(inventory);
  }

  async eraseCurrentPosition(sku: string) {
    const inventory = await this.findBySku(sku);
    inventory.currentPosition = 0;
    return this.inventoryRepository.save(inventory);
  }

  async exportXls() {
    // get inventory info for all product variations ordered by ncm
    const reportData = await this.inventoryRepository
      .createQueryBuilder('inventory')
      .leftJoin('inventory.productVariation', 'productVariation')
      .leftJoin('productVariation.product', 'product')
      .select([
        'productVariation.sku',
        'product.title',
        'productVariation.description',
        'inventory.current_position',
        'inventory.id',
      ])
      .orderBy('product.ncm')
      .getRawMany();

    const wb = XLSX.utils.book_new();
    wb.Props = {
      Title: 'Relatório de Estoque',
      CreatedDate: new Date(),
    };

    const workSheet = XLSX.utils.json_to_sheet(reportData);
    XLSX.utils.book_append_sheet(wb, workSheet, 'Estoque');

    XLSX.writeFile(wb, '/tmp/Estoque.xlsx');

    // melhorias a serem feitas:
    // 1. remover ID da spreadsheet gerada
    // 2. trocar os headers (por nomes em português)
    // 3. exibir uma coluna com NCM (a Tula pediu para ordernamos por NCM por ora)
    // 4. deixar a coluna `productVariation_description` em branco quando for `Tamanho Único`
    // 5. deixar colunas expandidas por padrão (se for fácil)
    // 6. trocar cor para cinza no botão de gerar o relatório
    // 7. trocar o título do botão para "Gerar Relatório"
    // 8. testar o download via ajax, exemplo: https://medium.com/@radicalloop/download-file-using-ajax-in-angular-4-50109564bf17 
  }
}
