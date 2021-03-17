import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { InventoryListComponent } from '@app/inventory/inventory-list/inventory-list.component';
import { InventoryComponent } from '@app/inventory/inventory.component';
import { extract } from '@app/i18n';
import { Shell } from '@app/shell/shell.service';
import { InventoryMovementsComponent } from './inventory-movements/inventory-movements.component';
import { IntenvoryReportComponent } from './intenvory-report/intenvory-report.component';

const routes: Routes = [
  Shell.childRoutes([
    {
      path: '',
      component: InventoryComponent,
      data: {
        title: extract('Inventory'),
        breadcrumb: 'Estoque',
      },
      children: [
        {
          path: '',
          component: InventoryListComponent,
          data: {
            title: 'Estoque',
            breadcrumb: 'Lista',
          },
        },
        {
          path: 'report',
          component: IntenvoryReportComponent,
          data: {
            title: 'Relátorio do Natal',
            breadcrumb: 'Relatorios',
          },
        },
        {
          path: ':id',
          component: InventoryMovementsComponent,
          data: {
            title: 'Movimentações de Estoque',
            breadcrumb: 'Movimentações',
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
export class InventoryRoutingModule {}
