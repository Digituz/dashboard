import { Injectable } from '@angular/core';
import { SalesOrderDTO } from './sales-order.dto';
import { IDataProvider, Pagination } from '@app/util/pagination';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root',
})
export class SalesOrdersService implements IDataProvider<SalesOrderDTO> {
  private SALES_ORDERS_ENDPOINT = '/sales-order';
  private BLING_INTEGRATION_ENDPOINT = '/bling';

  constructor(private httpClient: HttpClient) {}

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean,
    queryParams?: import('../util/pagination').QueryParam[]
  ): Observable<Pagination<SalesOrderDTO>> {
    let query = `${this.SALES_ORDERS_ENDPOINT}?page=${pageNumber}&limit=${pageSize}`;

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

    return this.httpClient.get<Pagination<SalesOrderDTO>>(query);
  }

  loadSalesOrder(referenceCode: string): Observable<SalesOrderDTO> {
    return this.httpClient.get<SalesOrderDTO>(`${this.SALES_ORDERS_ENDPOINT}/${referenceCode}`);
  }

  save(saleOrder: SalesOrderDTO): Observable<void> {
    return this.httpClient.post<void>(this.SALES_ORDERS_ENDPOINT, saleOrder);
  }

  syncWithBling(salesOrder: SalesOrderDTO) {
    return this.httpClient.post<void>(`${this.BLING_INTEGRATION_ENDPOINT}/${salesOrder.referenceCode}`, {});
  }
}
