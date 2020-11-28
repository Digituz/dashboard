import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { extract } from '@app/i18n';
import { Shell } from '@app/shell/shell.service';
import { PurchaseOrdersFormComponent } from './purchase-orders-form/purchase-orders-form.component';
import { PurchaseOrdersListComponent } from './purchase-orders-list/purchase-orders-list.component';
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
          component: PurchaseOrdersListComponent,
          data: {
            title: 'Lista de Compras',
            breadcrumb: 'Lista',
          },
        },
        {
          path: ':id',
          component: PurchaseOrdersFormComponent,
          data: {
            title: 'Nova Compra',
            breadcrumb: 'Compra',
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
