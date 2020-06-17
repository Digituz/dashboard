import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { InputTextModule } from 'primeng/inputtext';

import { SharedModule } from '../@shared/shared.module';
import { ProductsRoutingModule } from './products-routing.module';
import { ProductsComponent } from './products.component';
import { ProductFormComponent } from './product-form/product-form.component';
import { ProductsListComponent } from './products-list/products-list.component';
import { BreadcrumbsModule } from '@app/breadcrumbs/breadcrumbs.module';

@NgModule({
  declarations: [ProductsComponent, ProductFormComponent, ProductsListComponent],
  imports: [
    FormsModule,
    ReactiveFormsModule,
    SharedModule,
    CommonModule,
    InputTextModule,
    ProductsRoutingModule,
    BreadcrumbsModule,
  ],
})
export class ProductsModule {}
