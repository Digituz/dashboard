import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { SalesOrdersComponent } from './sales-orders.component';
import { SalesOrdersRoutingModule } from './sales-orders-routing.module';
import { SharedModule } from '@app/@shared';
import { DropdownModule } from 'primeng/dropdown';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ButtonModule } from 'primeng/button';
import { InputTextModule } from 'primeng/inputtext';
import { SalesOrderFormComponent } from './sales-order-form/sales-order-form.component';
import { SalesOrderListComponent } from './sales-order-list/sales-order-list.component';
import { CardModule } from 'primeng/card';
import { AutoCompleteModule } from 'primeng/autocomplete';
import { InputNumberModule } from 'primeng/inputnumber';

@NgModule({
  declarations: [SalesOrdersComponent, SalesOrderFormComponent, SalesOrderListComponent],
  imports: [
    FormsModule,
    ReactiveFormsModule,
    AutoCompleteModule,
    ButtonModule,
    CardModule,
    DropdownModule,
    InputTextModule,
    InputNumberModule,
    SharedModule,
    CommonModule,
    SalesOrdersRoutingModule,
  ],
})
export class SalesOrdersModule {}
