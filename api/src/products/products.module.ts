import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ProductsController } from './products.controller';
import { ProductsService } from './products.service';
import { Product } from './entities/product.entity';
import { ProductVariation } from './entities/product-variation.entity';
import { TagsModule } from 'src/tags/tags.module';

@Module({
    imports: [TagsModule, TypeOrmModule.forFeature([Product, ProductVariation])],
    providers: [ProductsService],
    controllers: [ProductsController]
})
export class ProductsModule {}
