import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { extract } from '@app/i18n';
import { Shell } from '@app/shell/shell.service';
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
          component: CouponComponent,
          data: {
            title: 'Lista de Cupoms',
            breadcrumb: 'Lista',
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
