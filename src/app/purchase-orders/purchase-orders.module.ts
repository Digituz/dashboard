import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { PurchaseOrdersComponent } from './purchase-orders.component';
import { PurchaseOrdersRoutingModule } from './purchase-orders-routing.module';

@NgModule({
  declarations: [PurchaseOrdersComponent],
  imports: [CommonModule, PurchaseOrdersRoutingModule],
})
export class PurchaseOrdersModule {}
