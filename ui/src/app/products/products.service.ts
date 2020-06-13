import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import Product from './product.entity';
import { Observable } from 'rxjs';
import { IDataProvider, Pagination } from '@app/util/pagination';

@Injectable({
  providedIn: 'root',
})
export class ProductsService implements IDataProvider<Product> {
  private PRODUCTS_ENDPOINT = '/products';

  constructor(private httpClient: HttpClient) {}

  loadData(pageNumber: number, pageSize: number): Observable<Pagination<Product>> {
    return this.httpClient.get<Pagination<Product>>(`${this.PRODUCTS_ENDPOINT}?page=${pageNumber}&limit=${pageSize}`);
  }

  public findProducts(query: string): Observable<Product[]> {
    return this.httpClient.get<Product[]>(`${this.PRODUCTS_ENDPOINT}?query=${query}`);
  }

  public saveProduct(product: Product): Observable<void> {
    return this.httpClient.post<void>(this.PRODUCTS_ENDPOINT, product);
  }

  loadProduct(productId: string) {
    return this.httpClient.get<Product>(`${this.PRODUCTS_ENDPOINT}/${productId}`);
  }
}
