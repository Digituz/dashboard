import { Component, OnInit, ViewChild } from '@angular/core';
import { DgzTableComponent } from '@app/@shared/dgz-table/dgz-table.component';
import { Pagination, QueryParam } from '@app/util/pagination';
import { Observable } from 'rxjs';
import { Supplier } from '../supplier.entity';
import { SupplierService } from '../supplier.service';

@Component({
  selector: 'app-supplier-list',
  templateUrl: './supplier-list.component.html',
  styleUrls: ['./supplier-list.component.scss'],
})
export class SupplierListComponent implements OnInit {
  @ViewChild('supplierTable') resultsTable: DgzTableComponent<Supplier>;
  queryParams: QueryParam[] = [];
  loading: boolean = true;
  query: string;

  constructor(private supplierService: SupplierService) {}

  ngOnInit(): void {}

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean,
    queryParams?: QueryParam[]
  ): Observable<Pagination<Supplier>> {
    return this.supplierService.loadData(pageNumber, pageSize, sortedBy, sortDirectionAscending, queryParams);
  }

  querySupplier() {
    this.queryParams = [{ key: 'query', value: this.query }];
    this.resultsTable.reload(this.queryParams);
  }

  updateQueryParams(queryParams: QueryParam[]) {
    this.query = queryParams.find((q) => q.key === 'query')?.value.toString();
  }

  clearStorage() {
    this.query = '';
    return localStorage.setItem('supplier-list', null);
  }
}
