import { Injectable } from '@angular/core';
import { IDataProvider, Pagination, QueryParam } from '@app/util/pagination';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Coupon } from './coupon.entity';

@Injectable({
  providedIn: 'root',
})
export class CouponService implements IDataProvider<Coupon> {
  private COUPON_ENDPOINT = '/coupon';

  constructor(private httpClient: HttpClient) {}

  public findCoupons(query: string): Observable<Pagination<Coupon>> {
    return this.httpClient.get<Pagination<Coupon>>(`${this.COUPON_ENDPOINT}?page=1&limit=10&query=${query}`);
  }

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean,
    queryParams?: QueryParam[]
  ): Observable<Pagination<Coupon>> {
    let query = `${this.COUPON_ENDPOINT}?page=${pageNumber}&limit=${pageSize}`;

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

    return this.httpClient.get<Pagination<Coupon>>(query);
  }

  public saveCoupon(coupon: Coupon): Observable<void> {
    return this.httpClient.post<void>(`${this.COUPON_ENDPOINT}/save`, coupon);
  }

  loadCoupon(id: string) {
    return this.httpClient.get<Coupon>(`${this.COUPON_ENDPOINT}/${id}`);
  }

  isCodeAvailable(code: string) {
    return this.httpClient.get<boolean>(`${this.COUPON_ENDPOINT}/is-code-available?code=${code}`);
  }
}
