import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import Product from '@app/products/product.entity';
import { Pagination, QueryParam } from '@app/util/pagination';
import { Observable } from 'rxjs';
import MLAd from './ml-ad.entity';
import MLCategory from './ml-category.entity';

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

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean,
    queryParams?: QueryParam[]
  ): Observable<Pagination<any>> {
    let query = `${this.MERCADO_LIVRE_END_POINT}/paginate?page=${pageNumber}&limit=${pageSize}`;

    if (sortedBy) {
      query += `&sortedBy=${sortedBy}`;
    }
    if (sortDirectionAscending !== undefined) {
      query += `&sortDirectionAscending=${sortDirectionAscending}`;
    }

    queryParams
      .filter((queryParam) => {
        return queryParam !== null && queryParam.value !== null && queryParam.value !== undefined;
      })
      .forEach((queryParam) => {
        query += `&${queryParam.key}=${queryParam.value}`;
      });

    return this.httpClient.get<Pagination<any>>(query);
  }

  loadProduct(sku: string) {
    return this.httpClient.get(`${this.MERCADO_LIVRE_END_POINT}/product?sku=${sku}`);
  }

  findCategories(query: string) {
    return this.httpClient.get(`${this.MERCADO_LIVRE_END_POINT}/category?query=${query}`);
  }

  loadErrors(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean,
    queryParams?: QueryParam[]
  ): Observable<Pagination<any>> {
    let query = `${this.MERCADO_LIVRE_END_POINT}/errors?page=${pageNumber}&limit=${pageSize}`;

    return this.httpClient.get<Pagination<any>>(query);
  }

  save(mlAd: MLAd) {
    return this.httpClient.post(`${this.MERCADO_LIVRE_END_POINT}/save`, mlAd);
  }

  saveAll(products: Product[], category: MLCategory, adType: string, additionalPrice: number) {
    const mlAds = { products, category, adType, additionalPrice };
    return this.httpClient.post(`${this.MERCADO_LIVRE_END_POINT}`, mlAds);
  }

  cleanUpErrors() {
    return this.httpClient.delete(`${this.MERCADO_LIVRE_END_POINT}/delete-erros`);
  }
}
