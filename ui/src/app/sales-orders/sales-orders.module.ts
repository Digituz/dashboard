import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { SalesOrdersComponent } from './sales-orders.component';
import { SalesOrdersRoutingModule } from './sales-orders-routing.module';
import { SharedModule } from '@app/@shared';
import { DropdownModule } from 'primeng/dropdown';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ButtonModule } from 'primeng/button';
import { InputTextModule } from 'primeng/inputtext';

@NgModule({
  declarations: [SalesOrdersComponent],
  imports: [
    FormsModule,
    ReactiveFormsModule,
    ButtonModule,
    DropdownModule,
    InputTextModule,
    SharedModule,
    CommonModule,
    SalesOrdersRoutingModule,
  ],
})
export class SalesOrdersModule {}
