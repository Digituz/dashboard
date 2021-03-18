import { Component, OnInit, ViewChild } from '@angular/core';
import { InventoryService } from '@app/inventory/inventory.service';
import { Observable } from 'rxjs';
import { Pagination, IDataProvider, QueryParam } from '@app/util/pagination';
import { Inventory } from '@app/inventory/inventory.entity';
import { DgzTableComponent } from '@app/@shared/dgz-table/dgz-table.component';
import { MoveInventoryDialogComponent } from '../move-inventory-dialog/move-inventory-dialog.component';
import { createAndDownloadBlobFile } from '../../util/util';
import { ProductCategory } from '@app/products/product-category.enum';
import { Category } from '@app/products/category.enum';

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
  categories: Category[] = [
    { label: 'Todas', value: null },
    { label: 'Acessórios', value: ProductCategory.ACESSORIOS },
    { label: 'Anéis', value: ProductCategory.ANEIS },
    { label: 'Berloques', value: ProductCategory.BERLOQUES },
    { label: 'Brincos', value: ProductCategory.BRINCOS },
    { label: 'Camisetas', value: ProductCategory.CAMISETAS },
    { label: 'Colares', value: ProductCategory.COLARES },
    { label: 'Conjuntos', value: ProductCategory.CONJUNTOS },
    { label: 'Decoração', value: ProductCategory.DECORACAO },
    { label: 'Pulseiras', value: ProductCategory.PULSEIRAS },
  ];
  category = this.categories[0].value;

  constructor(private inventoryService: InventoryService) {}

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean,
    queryParams?: QueryParam[]
  ): Observable<Pagination<Inventory>> {
    if (queryParams === undefined) {
      queryParams = [{ key: 'category', value: this.category }];
    }
    return this.inventoryService.loadData(pageNumber, pageSize, sortedBy, sortDirectionAscending, queryParams);
  }

  ngOnInit(): void {}

  openMovementDialog() {
    this.movementDialog.openDialog();
  }

  queryInventory() {
    this.queryParams = [
      { key: 'query', value: this.query },
      { key: 'category', value: this.category },
    ];
    this.resultsTable.reload(this.queryParams);
  }

  updateQueryParams(queryParams: QueryParam[]) {
    this.query = queryParams.find((q) => q.key === 'query')?.value?.toString();
    const savedCategory = queryParams.find((q) => q.key === 'category')?.value.toString();
    this.category = this.categories.find((o) => o.value === savedCategory).value;
  }

  xlsExport() {
    this.inventoryService.download(this.category).subscribe((res) => {
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
