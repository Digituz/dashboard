import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule } from '@angular/forms';
import { NzButtonModule } from 'ng-zorro-antd/button';
import { NzCardModule } from 'ng-zorro-antd/card';
import { NzDividerModule } from 'ng-zorro-antd/divider';
import { NzGridModule } from 'ng-zorro-antd/grid';
import { NzTableModule } from 'ng-zorro-antd/table';
import { NzFormModule } from 'ng-zorro-antd/form';
import { NzModalModule } from 'ng-zorro-antd/modal';
import { NzInputNumberModule } from 'ng-zorro-antd/input-number';
import { IconDefinition } from '@ant-design/icons-angular';
import { NzIconModule } from 'ng-zorro-antd/icon';
import { NzSkeletonModule } from 'ng-zorro-antd/skeleton';
import { NzSwitchModule } from 'ng-zorro-antd/switch';

import { SharedModule } from '../@shared/shared.module';
import { ProductsRoutingModule } from './products-routing.module';
import { ProductsComponent } from './products.component';
import { ProductFormComponent } from './product-form/product-form.component';
import { ProductsListComponent } from './products-list/products-list.component';
import { BreadcrumbsModule } from '@app/breadcrumbs/breadcrumbs.module';

import { CheckOutline, CloseOutline } from '@ant-design/icons-angular/icons';

const icons: IconDefinition[] = [CheckOutline, CloseOutline];

@NgModule({
  declarations: [ProductsComponent, ProductFormComponent, ProductsListComponent],
  imports: [
    ReactiveFormsModule,
    NzCardModule,
    NzDividerModule,
    NzFormModule,
    NzGridModule,
    NzInputNumberModule,
    NzTableModule,
    NzModalModule,
    NzSkeletonModule,
    NzSwitchModule,
    NzIconModule.forRoot(icons),
    SharedModule,
    CommonModule,
    ProductsRoutingModule,
    NzButtonModule,
    BreadcrumbsModule,
  ],
})
export class ProductsModule {}
