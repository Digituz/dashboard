import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { SharedModule } from '@app/@shared';
import { AutoCompleteModule } from 'primeng/autocomplete';
import { ButtonModule } from 'primeng/button';
import { DialogModule } from 'primeng/dialog';
import { InputNumberModule } from 'primeng/inputnumber';
import { InputTextModule } from 'primeng/inputtext';

import { InventoryRoutingModule } from '@app/inventory/inventory-routing.module';
import { InventoryListComponent } from '@app/inventory/inventory-list/inventory-list.component';
import { InventoryComponent } from '@app/inventory/inventory.component';
import { BreadcrumbsModule } from '@app/breadcrumbs/breadcrumbs.module';
import { MoveInventoryDialogComponent } from '@app/inventory/move-inventory-dialog/move-inventory-dialog.component';

@NgModule({
  declarations: [InventoryComponent, InventoryListComponent, MoveInventoryDialogComponent],
  imports: [
    FormsModule,
    ReactiveFormsModule,
    SharedModule,
    AutoCompleteModule,
    ButtonModule,
    DialogModule,
    InputNumberModule,
    InputTextModule,
    CommonModule,
    InventoryRoutingModule,
    BreadcrumbsModule,
  ],
})
export class InventoryModule {}
