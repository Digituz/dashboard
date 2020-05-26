import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ProductsController } from './products.controller';
import { ProductsService } from './products.service';
import { Product } from './entities/product.entity';
import { ProductVariation } from './entities/product-variation.entity';

@Module({
    imports: [TypeOrmModule.forFeature([Product, ProductVariation])],
    providers: [ProductsService],
    controllers: [ProductsController]
})
export class ProductsModule {}
