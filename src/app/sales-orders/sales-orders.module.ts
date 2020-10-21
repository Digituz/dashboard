import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { AutoCompleteModule } from 'primeng/autocomplete';
import { ButtonModule } from 'primeng/button';
import { CardModule } from 'primeng/card';
import { ConfirmDialogModule } from 'primeng/confirmdialog';
import { DropdownModule } from 'primeng/dropdown';
import { InputNumberModule } from 'primeng/inputnumber';
import { InputMaskModule } from 'primeng/inputmask';
import { InputTextModule } from 'primeng/inputtext';
import { TooltipModule } from 'primeng/tooltip';

import { SharedModule } from '@app/@shared';
import { SalesOrdersComponent } from './sales-orders.component';
import { SalesOrdersRoutingModule } from './sales-orders-routing.module';
import { SalesOrderFormComponent } from './sales-order-form/sales-order-form.component';
import { SalesOrderListComponent } from './sales-order-list/sales-order-list.component';
import { SalesOrdersReportComponent } from './sales-orders-report/sales-orders-report.component';

@NgModule({
  declarations: [SalesOrdersComponent, SalesOrderFormComponent, SalesOrderListComponent, SalesOrdersReportComponent],
  imports: [
    FormsModule,
    ReactiveFormsModule,
    AutoCompleteModule,
    ButtonModule,
    CardModule,
    DropdownModule,
    ConfirmDialogModule,
    InputTextModule,
    InputNumberModule,
    TooltipModule,
    SharedModule,
    CommonModule,
    InputMaskModule,
    SalesOrdersRoutingModule,
  ],
})
export class SalesOrdersModule {}
