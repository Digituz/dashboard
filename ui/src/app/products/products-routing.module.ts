import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { extract } from '@app/i18n';
import { ProductsComponent } from './products.component';
import { Shell } from '@app/shell/shell.service';
import { ProductFormComponent } from './product-form/product-form.component';
import { ProductsListComponent } from './products-list/products-list.component';

const routes: Routes = [
  Shell.childRoutes([
    {
      path: '',
      component: ProductsComponent,
      data: {
        title: extract('Products'),
        breadcrumb: 'Produtos',
      },
      children: [
        {
          path: '',
          component: ProductsListComponent,
          data: {
            title: 'Lista de Produtos',
            breadcrumb: 'Lista',
          },
        },
        {
          path: ':sku',
          component: ProductFormComponent,
          data: {
            title: 'Editar Produto',
            breadcrumb: 'Editar Produto',
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
export class ProductsRoutingModule {}
