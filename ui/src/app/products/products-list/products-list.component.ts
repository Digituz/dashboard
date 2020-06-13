import { Component, OnInit, ViewChild } from '@angular/core';
import Product from '../product.entity';
import { ProductsService } from '../products.service';
import { DgzTableComponent } from '@app/@shared/dgz-table/dgz-table.component';
import { IDataProvider, Pagination, QueryParam } from '@app/util/pagination';
import { Observable } from 'rxjs';
import { FormGroup, FormBuilder } from '@angular/forms';

@Component({
  selector: 'app-products-list',
  templateUrl: './products-list.component.html',
  styleUrls: ['./products-list.component.scss'],
})
export class ProductsListComponent implements OnInit, IDataProvider<Product> {
  @ViewChild('productsTable') appFoo: DgzTableComponent<Product>;
  products: Product[];
  query: string;
  isActive: string;
  withVariations: string;
  queryParams: QueryParam[] = [];

  constructor(private productsService: ProductsService, private fb: FormBuilder) {}

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean
  ): Observable<Pagination<Product>> {
    return this.productsService.loadData(pageNumber, pageSize, sortedBy, sortDirectionAscending, this.queryParams);
  }

  ngOnInit(): void {}

  queryProducts() {
    this.queryParams = [
      { key: 'query', value: this.query },
      { key: 'isActive', value: this.isActive },
      { key: 'withVariations', value: this.withVariations },
    ];
  }
}
