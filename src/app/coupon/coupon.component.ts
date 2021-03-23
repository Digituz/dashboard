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
  constructor() {}
  ngOnInit(): void {}
}
