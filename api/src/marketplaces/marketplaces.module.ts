import { Module } from '@nestjs/common';
import { ShopifyController } from './shopify/shopify.controller';
import { ShopifyService } from './shopify/shopify.service';
import { ProductsModule } from '../products/products.module';

@Module({
  imports: [ProductsModule],
  controllers: [ShopifyController],
  providers: [ShopifyService],
})
export class MarketplacesModule {}
