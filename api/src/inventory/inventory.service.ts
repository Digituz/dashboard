import { Injectable } from '@nestjs/common';
import { Pagination, paginate } from 'nestjs-typeorm-paginate';
import { Inventory } from './inventory.entity';
import { InventoryMovement } from './inventory-movement.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, Brackets } from 'typeorm';
import { IPaginationOpts } from '../pagination/pagination';
import { InventoryMovementDTO } from './inventory-movement.dto';
import { SaleOrder } from 'src/sales-order/entities/sale-order.entity';

@Injectable()
export class InventoryService {
  constructor(
    @InjectRepository(Inventory)
    private inventoryRepository: Repository<Inventory>,
    @InjectRepository(InventoryMovement)
    private inventoryMovementRepository: Repository<InventoryMovement>,
  ) {}

  async paginate(options: IPaginationOpts): Promise<Pagination<Inventory>> {
    const queryBuilder = this.inventoryRepository.createQueryBuilder('i');

    queryBuilder.leftJoinAndSelect('i.product', 'p');

    let orderColumn = '';

    switch (options.sortedBy?.trim()) {
      case undefined:
      case null:
      case 'title':
      case '':
        orderColumn = 'p.title';
        break;
      case 'sku':
        orderColumn = 'p.sku';
        break;
      case 'currentPosition':
        orderColumn = 'i.current_position';
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
                  query: `%${queryParam.value.toString().toLowerCase()}%`,
                }).orWhere(`lower(p.sku) like :query`, {
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

  findBySku(sku: string): Promise<Inventory> {
    return this.inventoryRepository
      .createQueryBuilder('i')
      .leftJoinAndSelect('i.product', 'p')
      .where('p.sku = :sku', { sku })
      .getOne();
  }

  async cleanUpMovements(saleOrder: SaleOrder) {
    const movements = await this.inventoryMovementRepository.find({
      saleOrder: saleOrder,
    });
    const removeMovementJobs = movements.map((movement) => {
      return new Promise((res) => {
        const inventory = movement.inventory;
        inventory.currentPosition -= movement.amount;
        this.inventoryRepository.save(inventory);
        res();
      });
    });
    await Promise.all(removeMovementJobs);
  }

  async saveMovement(
    inventoryMovementDTO: InventoryMovementDTO,
    saleOrder?: SaleOrder,
  ): Promise<InventoryMovement> {
    const inventory = await this.findBySku(inventoryMovementDTO.sku);
    inventory.currentPosition += inventoryMovementDTO.amount;
    await this.inventoryRepository.save(inventory);

    const movement: InventoryMovement = {
      inventory,
      amount: inventoryMovementDTO.amount,
      description: inventoryMovementDTO.description,
      saleOrder: saleOrder,
    };

    return this.inventoryMovementRepository.save(movement);
  }

  save(inventory: Inventory): Promise<Inventory> {
    return this.inventoryRepository.save(inventory);
  }
}
