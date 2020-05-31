import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NzBreadCrumbModule } from 'ng-zorro-antd/breadcrumb';
import { RouterModule } from '@angular/router';

import { BreadcrumbsComponent } from './breadcrumbs.component';

@NgModule({
  declarations: [BreadcrumbsComponent],
  imports: [CommonModule, RouterModule, NzBreadCrumbModule],
  exports: [BreadcrumbsComponent],
})
export class BreadcrumbsModule {}
