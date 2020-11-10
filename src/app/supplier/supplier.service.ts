import { Injectable } from '@angular/core';
import { Supplier } from './supplier.entity';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Pagination } from '@app/util/pagination';

import { QueryParam } from '../util/pagination';
import { map } from 'rxjs/operators';

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
    queryParams?: QueryParam[]
  ): Observable<Pagination<Supplier>> {
    let query = `${this.SUPPLIERS_ENDPOINT}/?page=${pageNumber}&limit=${pageSize}`;

    if (sortedBy) {
      query += `&sortedBy=${sortedBy}`;
    }
    if (sortDirectionAscending !== undefined) {
      query += `&sortDirectionAscending=${sortDirectionAscending}`;
    }
    if (queryParams) {
      query += queryParams
        .filter((queryParam) => queryParam !== null)
        .filter((queryParam) => !!queryParam.value)
        .map((queryParam) => `&${queryParam.key}=${queryParam.value}`)
        .join('');
    }
    return this.httpClient.get<Pagination<Supplier>>(query);
  }

  loadSupplier(id: string) {
    return this.httpClient.get<Supplier>(`${this.SUPPLIERS_ENDPOINT}/${id}`);
  }

  createSupplier(supplier: Supplier) {
    if (supplier.id) {
      return this.httpClient.put<void>(`${this.SUPPLIERS_ENDPOINT}/${supplier.id}`, supplier);
    }
    return this.httpClient.post<void>(this.SUPPLIERS_ENDPOINT, supplier);
  }

  loadSuppliers(query: string): Observable<Supplier[]> {
    return this.httpClient.get<Supplier[]>(`${this.SUPPLIERS_ENDPOINT}/findSuppliers?query=${query}`).pipe(
      map((suppliers) => {
        return suppliers.map((supplier) => ({
          ...supplier,
          completeDescription: `${supplier.name}`,
        }));
      })
    );
  }
}
