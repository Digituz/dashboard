import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { SalesOrdersComponent } from './sales-orders.component';
import { SalesOrdersRoutingModule } from './sales-orders-routing.module';


@NgModule({
  declarations: [SalesOrdersComponent],
  imports: [
    CommonModule,
    SalesOrdersRoutingModule,
  ]
})
export class SalesOrdersModule { }
