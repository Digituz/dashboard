import { Injectable } from '@nestjs/common';
import { Pagination, paginate } from 'nestjs-typeorm-paginate';
import { Inventory } from './inventory.entity';
import { InventoryMovement } from './inventory-movement.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, Brackets } from 'typeorm';
import { IPaginationOpts } from '../pagination/pagination';
import { InventoryMovementDTO } from './inventory-movement.dto';

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
                  query: `%${queryParam.value}%`,
                }).orWhere(`lower(p.sku) like :query`, {
                  query: `%${queryParam.value}%`,
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

  async saveMovement(
    inventoryMovementDTO: InventoryMovementDTO,
  ): Promise<InventoryMovement> {
    const inventory = await this.inventoryRepository.findOne(
      inventoryMovementDTO.inventoryId,
    );
    inventory.currentPosition += inventoryMovementDTO.amount;
    await this.inventoryRepository.save(inventory);

    const movement: InventoryMovement = {
      inventory,
      amount: inventoryMovementDTO.amount,
      description: inventoryMovementDTO.description,
    };
    return this.inventoryMovementRepository.save(movement);
  }

  save(inventory: Inventory): Promise<Inventory> {
    return this.inventoryRepository.save(inventory);
  }
}
