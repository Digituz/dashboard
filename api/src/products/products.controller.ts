import { Controller, Get, Body, Post, Param, UseGuards, Query } from '@nestjs/common';
import { Product } from './entities/product.entity';
import { ProductsService } from './products.service';
import { ProductDTO } from './dtos/product.dto';
import { ProductVariationDTO } from './dtos/product-variation.dto';
import { JwtAuthGuard } from 'src/auth/jwt-auth.guard';

@Controller('products')
@UseGuards(JwtAuthGuard)
export class ProductsController {
  constructor(private productsService: ProductsService) {}

  @Get()
  findAll(@Query('query') query: string): Promise<Product[]> {
    if (query) {
      return this.productsService.findByQuery(query);
    }
    return this.productsService.findAll();
  }

  @Get(':sku')
  findOne(@Param('sku') sku: string): Promise<Product> {
    return new Promise(async (res) => {
      const product = await this.productsService.findOneBySku(sku);
      res(product);
    });
  }

  @Post()
  async save(@Body() productDTO: ProductDTO) {
    this.productsService.save(productDTO);
  }

  @Post('variations')
  async saveVariation(
    @Body() productVariationDTO: ProductVariationDTO,
  ) {
    this.productsService.saveVariation(productVariationDTO);
  }
}
