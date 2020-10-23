import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { SharedModule } from '@app/@shared';
import { ButtonModule } from 'primeng/button';
import { InputTextModule } from 'primeng/inputtext';
import { CardModule } from 'primeng/card';
import { InputMaskModule } from 'primeng/inputmask';
import { BreadcrumbsModule } from '@app/breadcrumbs/breadcrumbs.module';

import { SupplierComponent } from './supplier.component';
import { SupplierRoutingModule } from './supplier-routing.module';
import { SupplierFormComponent } from './supplier-form/supplier-form.component';
import { SupplierListComponent } from './supplier-list/supplier-list.component';

@NgModule({
  declarations: [SupplierComponent, SupplierFormComponent, SupplierListComponent],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    SharedModule,
    ButtonModule,
    InputTextModule,
    InputMaskModule,
    BreadcrumbsModule,
    CardModule,
    SupplierRoutingModule,
  ],
})
export class SupplierModule {}
