import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CouponComponent } from './coupon.component';
import { CouponsRoutingModule } from './coupon-router.module';

@NgModule({
  declarations: [CouponComponent],
  imports: [CommonModule, CouponsRoutingModule],
})
export class CouponModule {}
