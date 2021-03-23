import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CouponComponent } from './coupon.component';
import { CouponsRoutingModule } from './coupon-router.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { SharedModule } from '@app/@shared';
import { ButtonModule } from 'primeng/button';
import { InputTextModule } from 'primeng/inputtext';
import { BreadcrumbsModule } from '@app/breadcrumbs/breadcrumbs.module';
import { InputMaskModule } from 'primeng/inputmask';
import { CardModule } from 'primeng/card';
import { DialogModule } from 'primeng/dialog';
import { DropdownModule } from 'primeng/dropdown';
import { InputNumberModule } from 'primeng/inputnumber';
import { InputSwitchModule } from 'primeng/inputswitch';
import { CalendarModule } from 'primeng/calendar';
import { CouponFormComponent } from './coupon-form/coupon-form.component';
import { CouponListComponent } from './coupon-list/coupon-list.component';
@NgModule({
  declarations: [CouponComponent, CouponFormComponent, CouponListComponent],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    SharedModule,
    ButtonModule,
    CardModule,
    InputTextModule,
    BreadcrumbsModule,
    CalendarModule,
    CommonModule,
    DropdownModule,
    InputNumberModule,
    InputMaskModule,
    InputSwitchModule,
    DialogModule,
    CouponsRoutingModule,
  ],
})
export class CouponModule {}
