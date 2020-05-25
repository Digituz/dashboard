import { Controller, Get } from '@nestjs/common';
import { Product } from './entities/product';

@Controller('products')
export class ProductsController {
  @Get()
  findAll(): Product[] {
    return [];
  }
}
