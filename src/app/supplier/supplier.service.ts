import { Injectable } from '@angular/core';
import { Supplier } from './supplier.entity';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Pagination } from '@app/util/pagination';

@Injectable({
  providedIn: 'root',
})
export class SupplierService {
  SUPPLIERS_ENDPOINT = '/suppliers';
  constructor(private httpClient: HttpClient) {}

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean,
    queryParams?: import('../util/pagination').QueryParam[]
  ): Observable<Pagination<Supplier>> {
    let query = `${this.SUPPLIERS_ENDPOINT}?page=${pageNumber}&limit=${pageSize}`;

    if (sortedBy) {
      query += `&sortedBy=${sortedBy}`;
    }
    if (sortDirectionAscending !== undefined) {
      query += `&sortDirectionAscending=${sortDirectionAscending}`;
    }

    if (queryParams) {
      queryParams
        .filter((queryParam) => {
          return queryParam !== null && queryParam.value !== null && queryParam.value !== undefined;
        })
        .forEach((queryParam) => {
          query += `&${queryParam.key}=${queryParam.value}`;
        });
    }
    return this.httpClient.get<Pagination<Supplier>>(query);
  }

  loadSupplier(id: string) {
    return this.httpClient.get<Supplier>(`${this.SUPPLIERS_ENDPOINT}/${id}`);
  }

  createSupplier(supplier: Supplier) {
    console.log(supplier.id);
    if (supplier.id) {
      return this.httpClient.put<void>(`${this.SUPPLIERS_ENDPOINT}/${supplier.id}`, supplier);
    }
    return this.httpClient.post<void>(this.SUPPLIERS_ENDPOINT, supplier);
  }
}
