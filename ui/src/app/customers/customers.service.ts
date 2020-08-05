import { Injectable } from '@angular/core';
import { IDataProvider, Pagination } from '@app/util/pagination';
import { Customer } from './customer.entity';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class CustomersService implements IDataProvider<Customer> {
  private CUSTOMERS_ENDPOINT = '/customers';

  constructor(private httpClient: HttpClient) {}

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean,
    queryParams?: import('../util/pagination').QueryParam[]
  ): Observable<Pagination<Customer>> {
    let query = `${this.CUSTOMERS_ENDPOINT}?page=${pageNumber}&limit=${pageSize}`;

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

    return this.httpClient.get<Pagination<Customer>>(query);
  }

  public saveCustomer(customer: Customer): Observable<void> {
    if (customer.id) {
      return this.httpClient.put<void>(`${this.CUSTOMERS_ENDPOINT}/${customer.id}`, customer);
    }
    return this.httpClient.post<void>(this.CUSTOMERS_ENDPOINT, customer);
  }

  loadCustomer(id: string) {
    return this.httpClient.get<Customer>(`${this.CUSTOMERS_ENDPOINT}/${id}`);
  }
}
