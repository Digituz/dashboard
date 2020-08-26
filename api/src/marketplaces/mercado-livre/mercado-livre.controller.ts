import { Controller, Post, Get, Query } from '@nestjs/common';
import { ProductsService } from 'src/products/products.service';

import meli from 'mercadolibre';

const ML_REDIRECT_URL = 'https://digituz.com.br/api/v1/mercado-livre';
const ML_CLIENT_ID = '6962689565848218';
const ML_CLIENT_SECRET = '0j9pICVyBzxaQ8zGI4UdGlj5HkjWXn6Q';

@Controller('mercado-livre')
export class MercadoLivreController {
  mercadoLivre: any;

  constructor(private productsService: ProductsService) {
    this.mercadoLivre = new meli.Meli(ML_CLIENT_ID, ML_CLIENT_SECRET);
  }

  @Get()
  getAuthURL(@Query('query') code?: string): string {
    if (!code) {
      return this.mercadoLivre.getAuthURL(ML_REDIRECT_URL);
    } else {
      this.mercadoLivre.authorize(code, ML_REDIRECT_URL, (err, res) => {
        console.log(res);
      });
    }
  }

  @Post('/')
  async save(): Promise<void> {
    // return this.shopifyService.syncProducts();
  }
}
