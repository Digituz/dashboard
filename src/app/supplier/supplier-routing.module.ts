import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { extract } from '@app/i18n';
import { Shell } from '@app/shell/shell.service';
import { SupplierFormComponent } from './supplier-form/supplier-form.component';
import { SupplierListComponent } from './supplier-list/supplier-list.component';
import { SupplierComponent } from './supplier.component';

const routes: Routes = [
  Shell.childRoutes([
    {
      path: '',
      component: SupplierComponent,
      data: {
        title: extract('Fornecedores'),
        breadcrumb: 'Fornecedores',
      },
      children: [
        {
          path: '',
          component: SupplierListComponent,
          data: {
            title: 'Lista de Fornecedores',
            breadcrumb: 'Lista',
          },
        },
        {
          path: ':id',
          component: SupplierFormComponent,
          data: {
            title: 'Editar Fornecedor',
            breadcrumb: 'Editar Fornecedor',
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
export class SupplierRoutingModule {}
