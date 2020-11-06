import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { extract } from '@app/i18n';
import { Shell } from '@app/shell/shell.service';
import { PurchaseOrdersComponent } from './purchase-orders.component';

const routes: Routes = [
  Shell.childRoutes([
    {
      path: '',
      component: PurchaseOrdersComponent,
      data: {
        title: extract('Compras'),
        breadcrumb: 'Compras',
      },
      children: [
        {
          path: '',
          component: PurchaseOrdersComponent,
          data: {
            title: 'Lista de Compras',
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
export class PurchaseOrdersRoutingModule {}
