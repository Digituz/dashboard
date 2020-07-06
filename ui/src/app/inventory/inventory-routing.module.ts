import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { InventoryListComponent } from '@app/inventory/inventory-list/inventory-list.component';
import { InventoryComponent } from '@app/inventory/inventory.component';
import { extract } from '@app/i18n';
import { Shell } from '@app/shell/shell.service';

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
      ],
    },
  ]),
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class InventoryRoutingModule {}
