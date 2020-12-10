import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class MercadoLivreService {
  MERCADO_LIVRE_END_POINT = '/mercado-livre';
  constructor(private httpClient: HttpClient) {}

  getAuthUrl() {
    return this.httpClient.get(`${this.MERCADO_LIVRE_END_POINT}/authorize`, { responseType: 'text' });
  }

  generateToken(code: string) {
    return this.httpClient.get(`${this.MERCADO_LIVRE_END_POINT}?code=${code}`);
  }

  getToken() {
    return this.httpClient.get(`${this.MERCADO_LIVRE_END_POINT}/token`);
  }
}
