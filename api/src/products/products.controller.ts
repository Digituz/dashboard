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
import { ProductVariationDTO } from './dtos/product-variation.dto';
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
    @Query('isActive') isActive: string,
    @Query('withVariations') withVariations: string,
  ): Promise<Pagination<Product>> {
    // if (query) {
    //   return this.productsService.findByQuery(query);
    // }
    return this.productsService.paginate({
      page,
      limit,
      sortedBy,
      sortDirectionAscending,
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

  @Post('variations')
  async saveVariation(@Body() productVariationDTO: ProductVariationDTO) {
    this.productsService.saveVariation(productVariationDTO);
  }
}
