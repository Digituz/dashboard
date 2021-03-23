import { Component, OnInit } from '@angular/core';
import { AbstractControl, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { format, isBefore } from 'date-fns';
import { Coupon } from '../coupon.entity';
import { CouponService } from '../coupon.service';
import { CustomCouponValidator } from '../coupon.validator';

interface couponsTypes {
  label: string;
  value: string;
}

@Component({
  selector: 'app-coupon-form',
  templateUrl: './coupon-form.component.html',
  styleUrls: ['./coupon-form.component.scss'],
})
export class CouponFormComponent implements OnInit {
  loading: boolean = true;
  coupon: Coupon;
  formFields: FormGroup;
  couponsTypes: couponsTypes[] = [
    { label: 'R$', value: 'R$' },
    { label: '%', value: 'percentage' },
    { label: 'EQUIPE', value: 'EQUIPE' },
    { label: 'SHIPPING', value: 'SHIPPING' },
  ];

  constructor(
    private couponService: CouponService,
    private fb: FormBuilder,
    private customCouponValidator: CustomCouponValidator,
    private router: Router,
    private route: ActivatedRoute
  ) {}

  ngOnInit(): void {
    const id = this.route.snapshot.params.id;

    if (id === 'new') {
      this.configureFormFields(null);
    } else {
      this.couponService.loadCoupon(id).subscribe((coupon) => {
        this.coupon = coupon;
        this.coupon.expirationDate = new Date(coupon.expirationDate);
        this.configureFormFields(coupon);
      });
    }
  }

  private configureFormFields(coupon: Coupon) {
    this.formFields = this.fb.group({
      code: [coupon?.code || null, Validators.required /*this.customCouponValidator.existingCode()*/],
      description: [coupon?.description || null, [Validators.required]],
      type: [coupon?.type || this.couponsTypes[0], [Validators.required]],
      value: [coupon?.value || null /* [Validators.required, Validators.min(0.01)] */],
      expirationDate: [coupon?.expirationDate || null, this.ValidateDate],
      active: [coupon?.active || true],
    });
    this.loading = false;
  }

  submitCoupon() {
    if (!this.formFields.valid) {
      this.markAllFieldsAsTouched(this.formFields);
    } else {
      const coupon = { ...this.formFields.value };
      console.log(coupon);
      coupon.value = coupon.value?.toFixed(2);
      coupon.expirationDate = format(coupon.expirationDate, 'yyyy-MM-dd');
      this.couponService.saveCoupon(coupon).subscribe(() => {});
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
