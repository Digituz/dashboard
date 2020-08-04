import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { extract } from '@app/i18n';
import { Shell } from '@app/shell/shell.service';
import { SalesOrdersComponent } from './sales-orders.component';

const routes: Routes = [
  Shell.childRoutes([
    {
      path: '',
      component: SalesOrdersComponent,
      data: {
        title: extract('Vendas'),
        breadcrumb: 'Vendas',
      },
    },
  ]),
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class SalesOrdersRoutingModule {}
