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
import { parseBoolean } from '../util/parsers';
import { Pagination } from 'nestjs-typeorm-paginate';
import { ProductVariationDetailsDTO } from './dtos/product-variation-details.dto';

@Controller('products')
@UseGuards(JwtAuthGuard)
export class ProductsController {
  constructor(private productsService: ProductsService) {}

  @Get('/variations')
  findProductVariations(
    @Query('query') query: string,
  ): Promise<ProductVariationDetailsDTO[]> {
    return this.productsService.findVariations(query);
  }

  @Get('/all')
  all(): Promise<Product[]> {
    return this.productsService.findAll();
  }

  @Get()
  query(
    @Query('page') page: number = 1,
    @Query('limit') limit: number = 10,
    @Query('sortedBy') sortedBy: string,
    @Query('sortDirectionAscending') sortDirectionAscending: string,
    @Query('query') query: string,
    @Query('isActive') isActive: string,
    @Query('withVariations') withVariations: string,
  ): Promise<Pagination<Product>> {
    return this.productsService.paginate({
      page,
      limit,
      sortedBy,
      sortDirectionAscending: parseBoolean(sortDirectionAscending),
      queryParams: [
        {
          key: 'query',
          value: query,
        },
        {
          key: 'isActive',
          value: parseBoolean(isActive),
        },
        {
          key: 'withVariations',
          value: parseBoolean(withVariations),
        },
      ],
    });
  }

  @Get(':sku')
  findOne(@Param('sku') sku: string): Promise<Product> {
    return this.productsService.findOneBySku(sku);
  }

  @Post()
  save(@Body() productDTO: ProductDTO): Promise<Product> {
    return this.productsService.save(productDTO);
  }
}
