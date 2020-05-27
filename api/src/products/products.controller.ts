import { Controller, Get, Body, Post, Param } from '@nestjs/common';
import { Product } from './entities/product.entity';
import { ProductsService } from './products.service';
import { CreateProductDTO } from './dtos/create-product.dto';
import { CreateProductVariationDTO } from './dtos/create-product-variation.dto';

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
      setTimeout(() => {
        res(this.productsService.findOneBySku(sku));
      }, 5000);
    });
  }

  @Post()
  async create(@Body() createProductDTO: CreateProductDTO) {
    this.productsService.save(createProductDTO);
  }

  @Post(':sku/variation')
  async createVariation(
    @Param('sku') parentSku: string,
    @Body() createProductDTO: CreateProductVariationDTO,
  ) {
    this.productsService.addVariation(parentSku, createProductDTO);
  }
}
