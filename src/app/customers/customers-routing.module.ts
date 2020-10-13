import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { extract } from '@app/i18n';
import { CustomersComponent } from './customers.component';
import { Shell } from '@app/shell/shell.service';
import { CustomersFormComponent } from './customers-form/customers-form.component';
import { CustomersListComponent } from './customers-list/customers-list.component';

const routes: Routes = [
  Shell.childRoutes([
    {
      path: '',
      component: CustomersComponent,
      data: {
        title: extract('Clientes'),
        breadcrumb: 'Clientes',
      },
      children: [
        {
          path: '',
          component: CustomersListComponent,
          data: {
            title: 'Lista de Clientes',
            breadcrumb: 'Lista',
          },
        },
        {
          path: ':id',
          component: CustomersFormComponent,
          data: {
            title: 'Editar Cliente',
            breadcrumb: 'Editar Cliente',
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
export class CustomersRoutingModule {}
