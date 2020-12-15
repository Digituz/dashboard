import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { extract } from '@app/i18n';
import { Shell } from '@app/shell/shell.service';
import { MercadoLivreComponent } from './mercado-livre.component';
import { MLProductListComponent } from './ml-product-list/ml-product-list.component';
import { MLProductFormComponent } from './ml-product-form/ml-product-form.component';

const routes: Routes = [
  Shell.childRoutes([
    {
      path: '',
      component: MercadoLivreComponent,
      data: {
        title: extract('Mercado Livre'),
      },
      children: [
        {
          path: 'list',
          component: MLProductListComponent,
          data: {
            title: extract('Produtos Mercado Livre'),
          },
        },
        {
          path: 'form/:sku',
          component: MLProductFormComponent,
          data: {
            title: extract('Formulário de Produtos mercado Livre'),
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
export class MercadoLivreRoutingModule {}
