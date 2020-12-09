import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { extract } from '@app/i18n';
import { Shell } from '@app/shell/shell.service';
import { UsersComponent } from './users.component';

const routes: Routes = [
  Shell.childRoutes([
    {
      path: '',
      component: UsersComponent,
      data: {
        title: extract('Usuário'),
        breadcrumb: 'Usuário',
      },
    },
  ]),
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class UsersRoutingModule {}
