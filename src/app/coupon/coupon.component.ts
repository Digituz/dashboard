import { Component, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { DgzTableComponent } from '@app/@shared/dgz-table/dgz-table.component';
import { Customer } from '@app/customers/customer.entity';
import { CustomersService } from '@app/customers/customers.service';
import { Pagination, QueryParam } from '@app/util/pagination';
import { Observable } from 'rxjs';
import { Coupon } from './coupon.entity';

interface couponsTypes {
  label: string;
  value: string;
}
@Component({
  selector: 'app-coupon',
  templateUrl: './coupon.component.html',
  styleUrls: ['./coupon.component.scss'],
})
export class CouponComponent implements OnInit {
  @ViewChild('couponsTable') resultsTable: DgzTableComponent<Customer>;
  queryParams: QueryParam[] = [];
  loading: boolean = false;
  query: string;
  couponsTypes: couponsTypes[] = [
    { label: 'R$', value: 'rs' },
    { label: '%', value: 'percentage' },
  ];

  isModalVisible: boolean = false;
  formFields: FormGroup;
  constructor(private customersService: CustomersService, private fb: FormBuilder) {}
  ngOnInit(): void {}

  private configureFormFields(coupon: Coupon) {
    this.formFields = this.fb.group({
      code: [coupon?.code || ''],
      type: [coupon?.type || ''],
      value: [coupon?.value || ''],
      active: [coupon?.active || null],
    });
    this.loading = false;
  }

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean,
    queryParams?: QueryParam[]
  ): Observable<Pagination<Customer>> {
    return this.customersService.loadData(pageNumber, pageSize, sortedBy, sortDirectionAscending, queryParams);
  }

  updateQueryParams(queryParams: QueryParam[]) {
    this.query = queryParams.find((q) => q.key === 'query')?.value.toString();
  }

  resetFilter() {
    this.query = '';
    return localStorage.removeItem('coupons-list');
  }

  showDialog() {
    this.isModalVisible = true;
    this.configureFormFields(null);
  }

  handleCancel() {
    this.loading = false;
    this.isModalVisible = false;
    this.formFields = null;
  }
}
