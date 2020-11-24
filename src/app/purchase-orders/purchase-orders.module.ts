import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { SharedModule } from '@app/@shared';
import { InputTextModule } from 'primeng/inputtext';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ButtonModule } from 'primeng/button';
import { CardModule } from 'primeng/card';
import { InputNumberModule } from 'primeng/inputnumber';
import { InputMaskModule } from 'primeng/inputmask';
import { AutoCompleteModule } from 'primeng/autocomplete';
import { DropdownModule } from 'primeng/dropdown';
import { TooltipModule } from 'primeng/tooltip';

import { PurchaseOrdersComponent } from './purchase-orders.component';
import { PurchaseOrdersRoutingModule } from './purchase-orders-routing.module';
import { PurchaseOrdersFormComponent } from './purchase-orders-form/purchase-orders-form.component';
import { PurchaseOrdersListComponent } from './purchase-orders-list/purchase-orders-list.component';

@NgModule({
  declarations: [PurchaseOrdersComponent, PurchaseOrdersFormComponent, PurchaseOrdersListComponent],
  imports: [
    CommonModule,
    PurchaseOrdersRoutingModule,
    SharedModule,
    InputTextModule,
    FormsModule,
    ReactiveFormsModule,
    ButtonModule,
    CardModule,
    InputNumberModule,
    InputMaskModule,
    AutoCompleteModule,
    InputNumberModule,
    TooltipModule,
    DropdownModule,
  ],
})
export class PurchaseOrdersModule {}
