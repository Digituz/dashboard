import {
  Controller,
  Query,
  Get,
  Param,
  Body,
  Post,
  UseGuards,
  Res,
  HttpStatus,
} from '@nestjs/common';
import { Response } from 'express';
import { Pagination } from 'nestjs-typeorm-paginate';
import { parseBoolean } from '../util/parsers';
import { InventoryService } from './inventory.service';
import { Inventory } from './inventory.entity';
import { InventoryMovementDTO } from './inventory-movement.dto';
import { InventoryMovement } from './inventory-movement.entity';
import { InventoryDTO } from './inventory.dto';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';

@Controller('inventory')
@UseGuards(JwtAuthGuard)
export class InventoryController {
  constructor(private inventoryService: InventoryService) {}

  @Get()
  async findAll(
    @Query('page') page: number = 1,
    @Query('limit') limit: number = 10,
    @Query('sortedBy') sortedBy: string,
    @Query('sortDirectionAscending') sortDirectionAscending: string,
    @Query('query') query: string,
  ): Promise<Pagination<InventoryDTO>> {
    const result = await this.inventoryService.paginate({
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
    const paginatedResults = {
      ...result,
      items: result.items.map(inventory => {
        return {
          id: inventory.id,
          productVariationDetails: {
            parentSku: inventory.productVariation.product.sku,
            sku: inventory.productVariation.sku,
            sellingPrice: inventory.productVariation.sellingPrice,
            title: inventory.productVariation.product.title,
            description: inventory.productVariation.description,
            currentPosition: inventory.productVariation.currentPosition,
          },
          currentPosition: inventory.currentPosition,
        };
      }),
    };
    return Promise.resolve(paginatedResults);
  }

  @Get('/xls')
  async exportXls(@Res() res: Response) {
    const buff = await this.inventoryService.exportXls();
    res.status(HttpStatus.OK).send(buff);
  }

  @Get(':id')
  findOne(@Param('id') id: number): Promise<Inventory> {
    return this.inventoryService.findById(id);
  }

  @Post('/movement')
  async save(
    @Body() inventoryMovementDTO: InventoryMovementDTO,
  ): Promise<InventoryMovement> {
    return this.inventoryService.saveMovement(inventoryMovementDTO);
  }
}
