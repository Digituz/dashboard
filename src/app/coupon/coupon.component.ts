import { Component, OnInit, ViewChild } from '@angular/core';
import { AbstractControl, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { DgzTableComponent } from '@app/@shared/dgz-table/dgz-table.component';
import { Customer } from '@app/customers/customer.entity';
import { Pagination, QueryParam } from '@app/util/pagination';
import { isBefore, format } from 'date-fns';
import { Observable } from 'rxjs';
import { Coupon } from './coupon.entity';
import { CouponService } from './coupon.service';
import { CustomCouponValidator } from './coupon.validator';

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
    { label: 'R$', value: 'R$' },
    { label: '%', value: 'percentage' },
  ];

  isModalVisible: boolean = false;
  formFields: FormGroup;
  constructor(
    private couponService: CouponService,
    private fb: FormBuilder,
    private customCouponValidator: CustomCouponValidator
  ) {}
  ngOnInit(): void {}

  private configureFormFields(coupon: Coupon) {
    this.formFields = this.fb.group({
      code: [coupon?.code || null, Validators.required, this.customCouponValidator.existingCode()],
      description: [coupon?.description || null, [Validators.required]],
      type: [coupon?.type || this.couponsTypes[0], [Validators.required]],
      value: [coupon?.value || null, [Validators.required, Validators.min(0.01)]],
      expirationDate: [coupon?.expirationDate || null, this.ValidateDate],
      active: [coupon?.active || true],
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
    return this.couponService.loadData(pageNumber, pageSize, sortedBy, sortDirectionAscending, queryParams);
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

  submitCoupon() {
    if (!this.formFields.valid) {
      this.markAllFieldsAsTouched(this.formFields);
    } else {
      const coupon = { ...this.formFields.value };
      coupon.value = coupon.value.toFixed(2);
      coupon.type = coupon.type.value;
      coupon.expirationDate = format(coupon.expirationDate, 'yyyy-MM-dd');
      this.couponService.saveCoupon(coupon).subscribe(() => {
        this.handleCancel();
        this.resultsTable.reload(this.queryParams);
      });
    }
  }

  markAllFieldsAsTouched(formGroup: FormGroup) {
    Object.keys(formGroup.controls).forEach((field) => {
      const control = formGroup.get(field);
      control.markAsTouched({ onlySelf: true });
    });
  }

  isFieldInvalid(field: string) {
    return !this.formFields.get(field).valid && this.formFields.get(field).touched;
  }

  ValidateDate(control: AbstractControl): { [key: string]: any } | null {
    if (isBefore(control.value, new Date())) {
      return { err: true };
    }
    return null;
  }
}
