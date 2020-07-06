import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { SharedModule } from '@app/@shared';
import { ButtonModule } from 'primeng/button';
import { DialogModule } from 'primeng/dialog';
import { InputTextModule } from 'primeng/inputtext';

import { InventoryRoutingModule } from '@app/inventory/inventory-routing.module';
import { InventoryListComponent } from '@app/inventory/inventory-list/inventory-list.component';
import { InventoryComponent } from '@app/inventory/inventory.component';
import { BreadcrumbsModule } from '@app/breadcrumbs/breadcrumbs.module';

@NgModule({
  declarations: [InventoryComponent, InventoryListComponent],
  imports: [
    FormsModule,
    SharedModule,
    ButtonModule,
    DialogModule,
    InputTextModule,
    CommonModule,
    InventoryRoutingModule,
    BreadcrumbsModule,
  ],
})
export class InventoryModule {}
