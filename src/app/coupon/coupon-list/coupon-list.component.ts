import { Component, OnInit, ViewChild } from '@angular/core';
import { DgzTableComponent } from '@app/@shared/dgz-table/dgz-table.component';
import { ComboBoxOption } from '@app/util/combo-box-option.interface';
import { Pagination, QueryParam } from '@app/util/pagination';
import { Observable } from 'rxjs';
import { Coupon } from '../coupon.entity';
import { CouponService } from '../coupon.service';

@Component({
  selector: 'app-coupon-list',
  templateUrl: './coupon-list.component.html',
  styleUrls: ['./coupon-list.component.scss'],
})
export class CouponListComponent implements OnInit {
  @ViewChild('couponsTable') resultsTable: DgzTableComponent<Coupon>;
  queryParams: QueryParam[] = [];
  statusOptions: ComboBoxOption[] = [
    { label: 'Todos', value: null },
    { label: 'Ativos', value: 'true' },
    { label: 'Inativos', value: 'false' },
  ];
  status: ComboBoxOption = this.statusOptions[0];
  query: string;

  constructor(private couponService: CouponService) {}

  ngOnInit(): void {}

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean,
    queryParams?: QueryParam[]
  ): Observable<Pagination<Coupon>> {
    return this.couponService.loadData(pageNumber, pageSize, sortedBy, sortDirectionAscending, queryParams);
  }

  updateQueryParams(queryParams: QueryParam[]) {
    this.query = queryParams.find((q) => q.key === 'query')?.value.toString();
    const selectedstatusStatusOption = queryParams.find((q) => q.key === 'status')?.value;
    if (selectedstatusStatusOption) {
      this.status = this.statusOptions.find((o) => o.value === selectedstatusStatusOption);
    }
  }

  queryCoupons() {
    this.queryParams = [
      { key: 'query', value: this.query },
      { key: 'status', value: this.status.value },
    ];

    this.resultsTable.reload(this.queryParams);
  }

  resetFilter() {
    this.query = '';
    return localStorage.removeItem('coupons-list');
  }
}
