import { Component, OnInit, ViewChild } from '@angular/core';
import { DgzTableComponent } from '@app/@shared/dgz-table/dgz-table.component';
import Product from '@app/products/product.entity';
import { ProductsService } from '@app/products/products.service';
import { Pagination, QueryParam } from '@app/util/pagination';
import { Observable } from 'rxjs';

@Component({
  selector: 'app-ml-product-list',
  templateUrl: './ml-product-list.component.html',
  styleUrls: ['./ml-product-list.component.scss'],
})
export class MlProductListComponent implements OnInit {
  @ViewChild('MLProductsTable') resultsTable: DgzTableComponent<any>;
  queryParams: QueryParam[] = [];
  query: string;
  constructor(private productService: ProductsService) {}

  ngOnInit(): void {}

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean,
    queryParams?: QueryParam[]
  ): Observable<Pagination<Product>> {
    return this.productService.loadData(pageNumber, pageSize, sortedBy, sortDirectionAscending, queryParams);
  }

  queryCustomers() {
    this.queryParams = [{ key: 'query', value: this.query }];
    this.resultsTable.reload(this.queryParams);
  }

  updateQueryParams(queryParams: QueryParam[]) {
    this.query = queryParams.find((q) => q.key === 'query')?.value.toString();
  }

  resetFilter() {
    this.query = '';
    return localStorage.removeItem('mercado-livre-list');
  }
}
