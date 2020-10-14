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
import { CardModule } from 'primeng/card';
import { CustomersReportComponent } from './customers-report/customers-report.component';

@NgModule({
  declarations: [CustomersListComponent, CustomersFormComponent, CustomersComponent, CustomersReportComponent],
  imports: [
    FormsModule,
    ReactiveFormsModule,
    SharedModule,
    ButtonModule,
    CardModule,
    SharedModule,
    InputTextModule,
    BreadcrumbsModule,
    CommonModule,
    CustomersRoutingModule,
  ],
})
export class CustomersModule {}
