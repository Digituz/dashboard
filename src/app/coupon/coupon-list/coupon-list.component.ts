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
  typeOptions: ComboBoxOption[] = [
    { label: 'Todos', value: null },
    { label: 'R$', value: 'R$' },
    { label: '%', value: 'PERCENTAGE' },
    { label: 'EQUIPE', value: 'EQUIPE' },
    { label: 'SHIPPING', value: 'SHIPPING' },
  ];
  type: ComboBoxOption = this.typeOptions[0];
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
    const selectedStatusOption = queryParams.find((q) => q.key === 'status')?.value;
    if (selectedStatusOption) {
      this.status = this.statusOptions.find((o) => o.value === selectedStatusOption);
    }
    const selectedTypeOption = queryParams.find((q) => q.key === 'Type')?.value;
    if (selectedTypeOption) {
      this.type = this.typeOptions.find((o) => o.value === selectedTypeOption);
    }
  }

  queryCoupons() {
    this.queryParams = [
      { key: 'query', value: this.query },
      { key: 'status', value: this.status.value },
      { key: 'type', value: this.type.value },
    ];

    this.resultsTable.reload(this.queryParams);
  }

  resetFilter() {
    this.query = '';
    this.type = this.typeOptions[0];
    this.status = this.statusOptions[0];
    return localStorage.removeItem('coupons-list');
  }
}
