import { Controller, Post, Get, Query } from '@nestjs/common';
import { ProductsService } from '../../products/products.service';

import meli from 'mercadolibre';

const ML_REDIRECT_URL = 'https://digituz.com.br/api/v1/mercado-livre';
const ML_CLIENT_ID = '6962689565848218';
const ML_CLIENT_SECRET = '0j9pICVyBzxaQ8zGI4UdGlj5HkjWXn6Q';
// const REFRESH_RATE = 3 * 60 * 60 * 1000; // every three hours
const REFRESH_RATE = 10 * 1000;

// http://localhost:3005/v1/mercado-livre?code=TG-5f46ab93c548f5000746c1c1-50194908

@Controller('mercado-livre')
export class MercadoLivreController {
  mercadoLivre: any;
  accessToken: string;
  refreshToken: string;

  constructor(private productsService: ProductsService) {
    this.mercadoLivre = new meli.Meli(ML_CLIENT_ID, ML_CLIENT_SECRET);
  }

  private refreshTokens() {
    this.mercadoLivre.refreshAccessToken(err => {
      if (err) console.error(err);
      console.log('mercado livre access token refreshed successfully');
    });
  }

  @Get()
  getAuthURL(@Query('code') code?: string): string {
    if (!code) {
      return this.mercadoLivre.getAuthURL(ML_REDIRECT_URL);
    } else {
      this.mercadoLivre.authorize(code, ML_REDIRECT_URL, (err, res) => {
        if (err) throw new Error(err);
        setInterval(() => {
          this.refreshTokens();
        }, REFRESH_RATE);
      });
    }
  }

  @Post('/')
  async save(): Promise<void> {
    // return this.shopifyService.syncProducts();
  }
}
