import { Injectable } from '@angular/core';
import { SalesOrderDTO } from './sales-order.dto';
import { IDataProvider, Pagination, QueryParam } from '@app/util/pagination';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { SalesOrderCustomerReport } from './sales-orders-report/sales-order-customer-report.interface';

@Injectable({
  providedIn: 'root',
})
export class SalesOrdersService implements IDataProvider<SalesOrderDTO> {
  private SALES_ORDERS_ENDPOINT = '/sales-order';

  constructor(private httpClient: HttpClient) {}

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean,
    queryParams?: QueryParam[]
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

  cancelOnBling(salesOrder: SalesOrderDTO) {
    return this.httpClient.delete<void>(`${this.SALES_ORDERS_ENDPOINT}/${salesOrder.referenceCode}`);
  }

  loadReport(queryParams?: QueryParam[]): Observable<Pagination<SalesOrderCustomerReport>> {
    let query = `${this.SALES_ORDERS_ENDPOINT}/report?page=1&whereRequisition=showScreen`;
    if (queryParams) {
      query += queryParams
        .filter((queryParam) => queryParam !== null)
        .filter((queryParam) => !!queryParam.value)
        .map((queryParam) => `&${queryParam.key}=${queryParam.value}`)
        .join('');
    }
    return this.httpClient.get<Pagination<SalesOrderCustomerReport>>(query);
  }

  download(groupBy: string, startDate: string, endDate: string): Observable<any> {
    const path = `${this.SALES_ORDERS_ENDPOINT}/report/xlsx?groupBy=${groupBy}&startDate=${startDate}&endDate=${endDate}`;
    return this.httpClient.get(path, { responseType: 'blob' });
  }
}
