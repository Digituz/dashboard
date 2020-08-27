import { Controller, Post, UseGuards } from '@nestjs/common';
import { ShopifyService } from './shopify.service';
import { JwtAuthGuard } from '../../auth/jwt-auth.guard';

@Controller('shopify')
@UseGuards(JwtAuthGuard)
export class ShopifyController {
  constructor(private shopifyService: ShopifyService) {}

  @Post('/')
  async save(): Promise<void> {
    return this.shopifyService.syncProducts();
  }
}
