import { Controller, Query, Get, Param, Body, Post } from '@nestjs/common';
import { Pagination } from 'nestjs-typeorm-paginate';
import { parseBoolean } from '../util/parsers';
import { InventoryService } from './inventory.service';
import { Inventory } from './inventory.entity';
import { InventoryMovementDTO } from './inventory-movement.dto';
import { InventoryMovement } from './inventory-movement.entity';

@Controller('inventory')
export class InventoryController {
  constructor(private inventoryService: InventoryService) {}

  @Get()
  findAll(
    @Query('page') page: number = 1,
    @Query('limit') limit: number = 10,
    @Query('sortedBy') sortedBy: string,
    @Query('sortDirectionAscending') sortDirectionAscending: string,
    @Query('query') query: string,
  ): Promise<Pagination<Inventory>> {
    return this.inventoryService.paginate({
      page,
      limit,
      sortedBy,
      sortDirectionAscending: parseBoolean(sortDirectionAscending),
      queryParams: [
        {
          key: 'query',
          value: query,
        },
      ],
    });
  }

  @Get(':id')
  findOne(@Param('id') id: number): Promise<Inventory> {
    return this.inventoryService.findById(id);
  }

  @Post('/movemnt')
  async save(
    @Body() inventoryMovementDTO: InventoryMovementDTO,
  ): Promise<InventoryMovement> {
    return this.inventoryService.saveMovement(inventoryMovementDTO);
  }
}
