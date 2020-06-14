import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import Product from './product.entity';
import { Observable } from 'rxjs';
import { IDataProvider, Pagination, QueryParam } from '@app/util/pagination';

@Injectable({
  providedIn: 'root',
})
export class ProductsService implements IDataProvider<Product> {
  private PRODUCTS_ENDPOINT = '/products';

  constructor(private httpClient: HttpClient) {}

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean,
    queryParams?: QueryParam[]
  ): Observable<Pagination<Product>> {
    let query = `${this.PRODUCTS_ENDPOINT}?page=${pageNumber}&limit=${pageSize}`;

    if (sortedBy) {
      query += `&sortedBy=${sortedBy}`;
    }
    if (sortDirectionAscending) {
      query += `&sortDirectionAscending=${sortDirectionAscending}`;
    }

    queryParams
      .filter((queryParam) => {
        return queryParam !== null && queryParam.value !== null && queryParam.value !== undefined;
      })
      .forEach((queryParam) => {
        query += `&${queryParam.key}=${queryParam.value}`;
      });

    return this.httpClient.get<Pagination<Product>>(query);
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
