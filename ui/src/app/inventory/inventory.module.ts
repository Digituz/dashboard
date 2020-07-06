import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { InventoryRoutingModule } from './inventory-routing.module';
import { InventoryListComponent } from './inventory-list/inventory-list.component';
import { FormsModule } from '@angular/forms';
import { SharedModule } from '@app/@shared';
import { ButtonModule } from 'primeng/button';
import { DialogModule } from 'primeng/dialog';

@NgModule({
  declarations: [InventoryListComponent],
  imports: [FormsModule, SharedModule, ButtonModule, DialogModule, CommonModule, InventoryRoutingModule],
})
export class InventoryModule {}
