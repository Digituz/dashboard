import { Injectable } from '@nestjs/common';
import meli from 'mercadolibre';
import { KeyValuePairService } from '../../key-value-pair/key-value-pair.service';

const ML_REDIRECT_URL = 'https://digituz.com.br/api/v1/mercado-livre';
const ML_CLIENT_ID = '6962689565848218';
const ML_CLIENT_SECRET = '0j9pICVyBzxaQ8zGI4UdGlj5HkjWXn6Q';
const ML_REFRESH_TOKEN_KEY = 'ML_REFRESH_TOKEN';
const ML_ACCESS_TOKEN_KEY = 'ML_ACCESS_TOKEN';
const REFRESH_RATE = 3 * 60 * 60 * 1000; // every three hours

@Injectable()
export class MercadoLivreService {
  private mercadoLivre;

  constructor(private keyValuePairService: KeyValuePairService) {}

  async onModuleInit(): Promise<void> {
    const rt = await this.keyValuePairService.get(ML_REFRESH_TOKEN_KEY);
    const at = await this.keyValuePairService.get(ML_ACCESS_TOKEN_KEY);
    this.mercadoLivre = new meli.Meli(
      ML_CLIENT_ID,
      ML_CLIENT_SECRET,
      at?.value,
      rt?.value,
    );

    if (rt && at) {
      this.startRefreshingTokens();
    }
  }

  private refreshTokens() {
    this.mercadoLivre.refreshAccessToken((err, res) => {
      if (err) return console.error(err);
      console.log(res);
      console.log('mercado livre access token refreshed successfully');
    });
  }

  private startRefreshingTokens() {
    this.refreshTokens();
    setInterval(() => {
      this.refreshTokens();
    }, REFRESH_RATE);
  }

  getAuthURL(): string {
    return this.mercadoLivre.getAuthURL(ML_REDIRECT_URL);
  }

  fetchTokens(code: string) {
    this.mercadoLivre.authorize(code, ML_REDIRECT_URL, (err, res) => {
      if (err) throw new Error(err);

      const refreshToken = res.refresh_token;
      const accessToken = res.access_token;

      this.keyValuePairService.set({
        key: ML_REFRESH_TOKEN_KEY,
        value: refreshToken,
      });

      this.keyValuePairService.set({
        key: ML_ACCESS_TOKEN_KEY,
        value: accessToken,
      });

      this.startRefreshingTokens();
    });
  }
}
