import { Component, OnInit, ViewChild } from '@angular/core';
import { InventoryService } from '@app/inventory/inventory.service';
import { Observable } from 'rxjs';
import { Pagination, IDataProvider, QueryParam } from '@app/util/pagination';
import { Inventory } from '@app/inventory/inventory.entity';
import { DgzTableComponent } from '@app/@shared/dgz-table/dgz-table.component';
import { MoveInventoryDialogComponent } from '../move-inventory-dialog/move-inventory-dialog.component';
import { createAndDownloadBlobFile } from '../../util/util';

@Component({
  selector: 'app-inventory-list',
  templateUrl: './inventory-list.component.html',
  styleUrls: ['./inventory-list.component.scss'],
})
export class InventoryListComponent implements OnInit, IDataProvider<Inventory> {
  @ViewChild('inventoryTable') resultsTable: DgzTableComponent<Inventory>;
  @ViewChild('movementDialog') movementDialog: MoveInventoryDialogComponent;
  inventory: Inventory[];
  query: string;
  queryParams: QueryParam[] = [];

  constructor(private inventoryService: InventoryService) {}

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean,
    queryParams?: QueryParam[]
  ): Observable<Pagination<Inventory>> {
    return this.inventoryService.loadData(pageNumber, pageSize, sortedBy, sortDirectionAscending, queryParams);
  }

  ngOnInit(): void {}

  openMovementDialog() {
    this.movementDialog.openDialog();
  }

  queryInventory() {
    this.queryParams = [{ key: 'query', value: this.query }];
    this.resultsTable.reload(this.queryParams);
  }

  updateQueryParams(queryParams: QueryParam[]) {
    this.query = queryParams.find((q) => q.key === 'query')?.value?.toString();
  }

  xlsExport() {
    this.inventoryService.download().subscribe((res) => {
      const options = { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' };
      const filename = 'Estoque.xlsx';
      createAndDownloadBlobFile(res, options, filename);
    });
  }

  resetFilter() {
    this.query = '';
    return localStorage.removeItem('inventory-list');
  }
}
