import { Controller, Get, Body, Post, Param } from '@nestjs/common';
import { Product } from './entities/product.entity';
import { ProductsService } from './products.service';
import { ProductDTO } from './dtos/product.dto';
import { ProductVariationDTO } from './dtos/product-variation.dto';

@Controller('products')
export class ProductsController {
  constructor(private productsService: ProductsService) {}

  @Get()
  findAll(): Promise<Product[]> {
    return this.productsService.findAll();
  }

  @Get(':sku')
  findOne(@Param('sku') sku: string): Promise<Product> {
    return new Promise((res) => {
      res(this.productsService.findOneBySku(sku));
    });
  }

  @Post()
  async save(@Body() productDTO: ProductDTO) {
    this.productsService.save(productDTO);
  }

  @Post(':sku/variation')
  async saveVariation(
    @Body() productVariationDTO: ProductVariationDTO,
  ) {
    this.productsService.saveVariation(productVariationDTO);
  }
}
