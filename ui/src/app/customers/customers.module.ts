import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CustomersListComponent } from './customers-list/customers-list.component';
import { CustomersFormComponent } from './customers-form/customers-form.component';
import { CustomersComponent } from './customers.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { SharedModule } from '@app/@shared';
import { ButtonModule } from 'primeng/button';
import { InputTextModule } from 'primeng/inputtext';
import { BreadcrumbsModule } from '@app/breadcrumbs/breadcrumbs.module';
import { CustomersRoutingModule } from './customers-routing.module';

@NgModule({
  declarations: [CustomersListComponent, CustomersFormComponent, CustomersComponent],
  imports: [
    FormsModule,
    ReactiveFormsModule,
    SharedModule,
    ButtonModule,
    SharedModule,
    InputTextModule,
    BreadcrumbsModule,
    CommonModule,
    CustomersRoutingModule,
  ],
})
export class CustomersModule {}
