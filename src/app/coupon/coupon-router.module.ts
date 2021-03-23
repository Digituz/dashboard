import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { extract } from '@app/i18n';
import { Shell } from '@app/shell/shell.service';
import { CouponFormComponent } from './coupon-form/coupon-form.component';
import { CouponListComponent } from './coupon-list/coupon-list.component';
import { CouponComponent } from './coupon.component';

const routes: Routes = [
  Shell.childRoutes([
    {
      path: '',
      component: CouponComponent,
      data: {
        title: extract('Cupoms'),
        breadcrumb: 'Cupoms',
      },
      children: [
        {
          path: '',
          component: CouponListComponent,
          data: {
            title: 'Lista de Cupoms',
            breadcrumb: 'Lista',
          },
        },
        {
          path: ':id',
          component: CouponFormComponent,
          data: {
            title: 'Editar Cupom',
            breadcrumb: 'Editar Cupom',
          },
        },
      ],
    },
  ]),
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class CouponsRoutingModule {}
