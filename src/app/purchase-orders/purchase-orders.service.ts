import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Pagination, QueryParam } from '@app/util/pagination';
import { Observable } from 'rxjs';
import { PurchaseOrder } from './purchase-order.entity';

@Injectable({
  providedIn: 'root',
})
export class PurchaseOrdersService {
  PURCHASE_ORDER_ENDPOINT = '/purchase-orders';
  constructor(private httpClient: HttpClient) {}

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean,
    queryParams?: QueryParam[]
  ): Observable<Pagination<PurchaseOrder>> {
    let query = `${this.PURCHASE_ORDER_ENDPOINT}/?page=${pageNumber}&limit=${pageSize}`;

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
    return this.httpClient.get<Pagination<PurchaseOrder>>(query);
  }
}
