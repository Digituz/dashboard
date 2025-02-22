import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { SalesOrderDTO } from '@app/sales-orders/sales-order.dto';
import { Pagination } from '@app/util/pagination';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class HomeService {
  private SALES_ORDERS_ENDPOINT = '/sales-order';
  private HOME_CHART_ENDPOINT = '/chart/home';
  constructor(private httpClient: HttpClient) {}

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean,
    queryParams?: import('../util/pagination').QueryParam[]
  ): Observable<Pagination<SalesOrderDTO>> {
    let query = `${this.SALES_ORDERS_ENDPOINT}/confirmed-sales-orders?page=${pageNumber}&limit=1000`;

    if (sortedBy) {
      query += `&sortedBy=${sortedBy}`;
    }
    if (sortDirectionAscending !== undefined) {
      query += `&sortDirectionAscending=${sortDirectionAscending}`;
    }
    return this.httpClient.get<Pagination<SalesOrderDTO>>(query);
  }

  loadChartData() {
    return this.httpClient.get(`${this.HOME_CHART_ENDPOINT}`);
  }
}
