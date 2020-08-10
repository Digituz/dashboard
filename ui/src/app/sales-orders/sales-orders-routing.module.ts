import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { extract } from '@app/i18n';
import { Shell } from '@app/shell/shell.service';
import { SalesOrdersComponent } from './sales-orders.component';
import { SalesOrderFormComponent } from './sales-order-form/sales-order-form.component';
import { SalesOrderListComponent } from './sales-order-list/sales-order-list.component';

const routes: Routes = [
  Shell.childRoutes([
    {
      path: '',
      component: SalesOrdersComponent,
      data: {
        title: extract('Vendas'),
        breadcrumb: 'Vendas',
      },
      children: [
        {
          path: '',
          component: SalesOrderListComponent,
          data: {
            title: 'Lista de Vendas',
            breadcrumb: 'Lista',
          },
        },
        {
          path: ':referenceCode',
          component: SalesOrderFormComponent,
          data: {
            title: 'Editar Venda',
            breadcrumb: 'Editar Venda',
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
export class SalesOrdersRoutingModule {}
