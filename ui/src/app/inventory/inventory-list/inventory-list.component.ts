import { Component, OnInit, ViewChild } from '@angular/core';
import { InventoryService } from '@app/inventory/inventory.service';
import { Observable } from 'rxjs';
import { Pagination, IDataProvider, QueryParam } from '@app/util/pagination';
import { Inventory } from '@app/inventory/inventory.entity';
import { DgzTableComponent } from '@app/@shared/dgz-table/dgz-table.component';
import { MoveInventoryDialogComponent } from '../move-inventory-dialog/move-inventory-dialog.component';

@Component({
  selector: 'app-inventory-list',
  templateUrl: './inventory-list.component.html',
  styleUrls: ['./inventory-list.component.scss'],
})
export class InventoryListComponent implements OnInit, IDataProvider<Inventory> {
  @ViewChild('inventoryTable') appFoo: DgzTableComponent<Inventory>;
  @ViewChild('movementDialog') movementDialog: MoveInventoryDialogComponent;
  inventory: Inventory[];
  query: string;
  queryParams: QueryParam[] = [];

  constructor(private inventoryService: InventoryService) {}

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean
  ): Observable<Pagination<Inventory>> {
    return this.inventoryService.loadData(pageNumber, pageSize, sortedBy, sortDirectionAscending, this.queryParams);
  }

  ngOnInit(): void {}

  queryInventory() {
    this.queryParams = [{ key: 'query', value: this.query }];
  }

  openMovementDialog() {
    this.movementDialog.openDialog();
  }
}
