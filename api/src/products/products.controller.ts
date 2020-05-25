import { Controller, Get, Body, Post } from '@nestjs/common';
import { Product } from './entities/product.entity';
import { ProductsService } from './products.service';
import { CreateProductDTO } from './dtos/create-product.dto';

@Controller('products')
export class ProductsController {
  constructor(private productService: ProductsService) {}

  @Get()
  findAll(): Promise<Product[]> {
    return this.productService.findAll();
  }

  @Post()
  async create(@Body() createProductDTO: CreateProductDTO) {
    this.productService.save(createProductDTO);
  }
}
