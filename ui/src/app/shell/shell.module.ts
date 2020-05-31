import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { TranslateModule } from '@ngx-translate/core';
import { RouterModule } from '@angular/router';
import { NzIconModule } from 'ng-zorro-antd/icon';
import { IconDefinition } from '@ant-design/icons-angular';
import { NzLayoutModule } from 'ng-zorro-antd/layout';
import { NzMenuModule } from 'ng-zorro-antd/menu';

import { I18nModule } from '@app/i18n';
import { ShellComponent } from './shell.component';
import { HeaderComponent } from './header/header.component';
import { BreadcrumbsModule } from '../breadcrumbs/breadcrumbs.module';

import {
  GoldOutline,
  DeploymentUnitOutline,
  HomeOutline,
  UserOutline,
  LaptopOutline,
  NotificationOutline,
} from '@ant-design/icons-angular/icons';

const icons: IconDefinition[] = [
  GoldOutline,
  DeploymentUnitOutline,
  HomeOutline,
  UserOutline,
  LaptopOutline,
  NotificationOutline,
];

@NgModule({
  imports: [
    CommonModule,
    TranslateModule,
    I18nModule,
    RouterModule,
    NzLayoutModule,
    NzMenuModule,
    NzIconModule.forRoot(icons),
    BreadcrumbsModule,
  ],
  declarations: [HeaderComponent, ShellComponent],
})
export class ShellModule {}
