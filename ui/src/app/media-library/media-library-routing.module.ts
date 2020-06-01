import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { extract } from '@app/i18n';
import { Shell } from '@app/shell/shell.service';
import { MediaLibraryComponent } from './media-library.component';

const routes: Routes = [
  Shell.childRoutes([
    {
      path: '',
      component: MediaLibraryComponent,
      data: {
        title: extract('Imagens'),
        breadcrumb: 'Imagens',
      },
    },
  ]),
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class MediaLibraryRoutingModule {}
