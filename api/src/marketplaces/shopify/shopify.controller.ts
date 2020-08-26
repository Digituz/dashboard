import { Controller, Post, Get } from '@nestjs/common';
import { ShopifyService } from './shopify.service';

@Controller('shopify')
export class ShopifyController {
  constructor(private shopifyService: ShopifyService) {}

  @Post('/')
  async save(): Promise<void> {
    return this.shopifyService.syncProducts();
  }
}
