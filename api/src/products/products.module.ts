import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ProductsController } from './products.controller';
import { ProductsService } from './products.service';
import { Product } from './entities/product.entity';
import { ProductVariation } from './entities/product-variation.entity';
import { ProductComposition } from './entities/product-composition.entity';
import { TagsModule } from '../tags/tags.module';
import { ProductImage } from './entities/product-image.entity';
import { MediaLibraryModule } from '../media-library/media-library.module';
import { InventoryModule } from '../inventory/inventory.module';

@Module({
  imports: [
    InventoryModule,
    TagsModule,
    MediaLibraryModule,
    TypeOrmModule.forFeature([
      Product,
      ProductVariation,
      ProductComposition,
      ProductImage,
    ]),
  ],
  providers: [ProductsService],
  controllers: [ProductsController],
  exports: [ProductsService],
})
export class ProductsModule {}
