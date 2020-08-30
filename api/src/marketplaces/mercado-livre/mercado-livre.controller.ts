import { Controller, Post, Get, Query, UseGuards, Put } from '@nestjs/common';
import { MercadoLivreService } from './mercado-livre.service';
import { JwtAuthGuard } from '../../auth/jwt-auth.guard';

@Controller('mercado-livre')
@UseGuards(JwtAuthGuard)
export class MercadoLivreController {
  mercadoLivre: any;
  accessToken: string;
  refreshToken: string;

  constructor(private mercadoLivreService: MercadoLivreService) {}

  @Get()
  fetchTokens(@Query('code') code: string) {
    this.mercadoLivreService.fetchTokens(code);
  }

  @Get('/authorize')
  authenticate(): string {
    return this.mercadoLivreService.getAuthURL();
  }

  @Post('/')
  async save(): Promise<void> {
    return this.mercadoLivreService.createProducts();
  }

  @Put('/')
  async update(): Promise<void> {
    return this.mercadoLivreService.updateProducts();
  }
}
