import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { TranslateModule } from '@ngx-translate/core';
import { RouterModule } from '@angular/router';

import { I18nModule } from '@app/i18n';
import { ShellComponent } from './shell.component';
import { HeaderComponent } from './header/header.component';
import { BreadcrumbsModule } from '../breadcrumbs/breadcrumbs.module';

@NgModule({
  imports: [
    CommonModule,
    TranslateModule,
    I18nModule,
    RouterModule,
    BreadcrumbsModule,
  ],
  declarations: [HeaderComponent, ShellComponent],
})
export class ShellModule {}
