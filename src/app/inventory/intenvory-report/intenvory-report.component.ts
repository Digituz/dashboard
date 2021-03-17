import { Component, OnInit, ViewChild } from '@angular/core';
import { DgzTableComponent } from '@app/@shared/dgz-table/dgz-table.component';
import { Pagination, QueryParam } from '@app/util/pagination';
import { createAndDownloadBlobFile } from '@app/util/util';
import { Observable } from 'rxjs';
import { ProductCategory } from '../../products/product-category.enum';
import { InventoryMovement } from '../inventory-movement.entity';
import { InventoryService } from '../inventory.service';
interface Category {
  label: string;
  value: string;
}

@Component({
  selector: 'app-intenvory-report',
  templateUrl: './intenvory-report.component.html',
  styleUrls: ['./intenvory-report.component.scss'],
})
export class IntenvoryReportComponent implements OnInit {
  @ViewChild('resultsInventoryTable') resultsInventoryTable: DgzTableComponent<any>;
  query: string;
  categories: Category[] = [
    { label: 'Todas', value: 'ALL' },
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
  queryParams: QueryParam[] = [];

  constructor(private inventoryService: InventoryService) {}

  ngOnInit(): void {}

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean,
    queryParams?: QueryParam[]
  ): Observable<Pagination<InventoryMovement>> {
    if (queryParams === undefined) {
      queryParams = [{ key: 'category', value: this.category }];
    }
    return this.inventoryService.loadReport(queryParams);
  }

  updateQueryParams(queryParams: QueryParam[]) {
    const savedCategory = queryParams.find((q) => q.key === 'category')?.value.toString();
    this.category = this.categories.find((o) => o.value === savedCategory).value.toString();
  }

  submitReport() {
    this.queryParams = [{ key: 'category', value: this.category }];
    if (this.resultsInventoryTable) {
      this.resultsInventoryTable.reload(this.queryParams);
    }
  }

  xlsExport() {
    this.inventoryService.download(this.category).subscribe((res) => {
      const options = { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' };
      const filename = 'Estoque.xlsx';
      createAndDownloadBlobFile(res, options, filename);
    });
  }
}
