import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { SharedModule } from '@app/@shared';
import { AutoCompleteModule } from 'primeng/autocomplete';
import { ButtonModule } from 'primeng/button';
import { DialogModule } from 'primeng/dialog';
import { DropdownModule } from 'primeng/dropdown';
import { InputNumberModule } from 'primeng/inputnumber';
import { InputTextModule } from 'primeng/inputtext';
import { SelectButtonModule } from 'primeng/selectbutton';

import { InventoryRoutingModule } from '@app/inventory/inventory-routing.module';
import { InventoryListComponent } from '@app/inventory/inventory-list/inventory-list.component';
import { InventoryComponent } from '@app/inventory/inventory.component';
import { BreadcrumbsModule } from '@app/breadcrumbs/breadcrumbs.module';
import { MoveInventoryDialogComponent } from '@app/inventory/move-inventory-dialog/move-inventory-dialog.component';
import { InventoryMovementsComponent } from './inventory-movements/inventory-movements.component';
import { IntenvoryReportComponent } from './intenvory-report/intenvory-report.component';
import { CardModule } from 'primeng/card';

@NgModule({
  declarations: [
    InventoryComponent,
    InventoryListComponent,
    MoveInventoryDialogComponent,
    InventoryMovementsComponent,
    IntenvoryReportComponent,
  ],
  imports: [
    FormsModule,
    ReactiveFormsModule,
    SharedModule,
    AutoCompleteModule,
    CardModule,
    ButtonModule,
    DialogModule,
    DropdownModule,
    InputNumberModule,
    InputTextModule,
    SelectButtonModule,
    CommonModule,
    InventoryRoutingModule,
    BreadcrumbsModule,
  ],
})
export class InventoryModule {}
