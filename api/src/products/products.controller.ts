import {
  Controller,
  Get,
  Body,
  Post,
  Param,
  UseGuards,
  Query,
} from '@nestjs/common';
import { Product } from './entities/product.entity';
import { ProductsService } from './products.service';
import { ProductDTO } from './dtos/product.dto';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';
import { Pagination } from 'nestjs-typeorm-paginate';

@Controller('products')
@UseGuards(JwtAuthGuard)
export class ProductsController {
  constructor(private productsService: ProductsService) {}

  @Get()
  findAll(
    @Query('page') page: number = 1,
    @Query('limit') limit: number = 10,
    @Query('sortedBy') sortedBy: string,
    @Query('sortDirectionAscending') sortDirectionAscending: boolean,
    @Query('query') query: string,
    @Query('isActive') isActive: string | boolean,
    @Query('withVariations') withVariations: string | boolean,
  ): Promise<Pagination<Product>> {
    return this.productsService.paginate({
      page,
      limit,
      sortedBy,
      sortDirectionAscending,
      queryParams: [
        {
          key: 'query',
          value: query,
        },
        {
          key: 'isActive',
          value: isActive,
        },
        {
          key: 'withVariations',
          value: withVariations,
        },
      ],
    });
  }

  @Get(':sku')
  findOne(@Param('sku') sku: string): Promise<Product> {
    return new Promise(async res => {
      const product = await this.productsService.findOneBySku(sku);
      res(product);
    });
  }

  @Post()
  async save(@Body() productDTO: ProductDTO) {
    this.productsService.save(productDTO);
  }
}
