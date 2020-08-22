import { Component, OnInit, ViewChild } from '@angular/core';
import Product from '../product.entity';
import { ProductsService } from '../products.service';
import { DgzTableComponent } from '@app/@shared/dgz-table/dgz-table.component';
import { IDataProvider, Pagination, QueryParam } from '@app/util/pagination';
import { Observable } from 'rxjs';

interface IsActiveOption {
  label: string;
  value: boolean;
}

interface WithVariationsOption {
  label: string;
  value: string;
}

@Component({
  selector: 'app-products-list',
  templateUrl: './products-list.component.html',
  styleUrls: ['./products-list.component.scss'],
})
export class ProductsListComponent implements OnInit, IDataProvider<Product> {
  @ViewChild('productsTable') appFoo: DgzTableComponent<Product>;
  products: Product[];
  query: string;
  withVariationsOptions: WithVariationsOption[] = [
    { label: 'Todos', value: null },
    { label: 'Com variações', value: 'true' },
    { label: 'Sem variações', value: 'false' },
  ];
  withVariations: WithVariationsOption = this.withVariationsOptions[0];
  isActiveOptions: IsActiveOption[] = [
    { label: 'Todos', value: null },
    { label: 'Ativos', value: true },
    { label: 'Inativos', value: false },
  ];
  isActive: IsActiveOption = this.isActiveOptions[1];
  queryParams: QueryParam[] = [{ key: 'isActive', value: this.isActive.value }];

  constructor(private productsService: ProductsService) {}

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
      { key: 'isActive', value: this.isActive.value },
      { key: 'withVariations', value: this.withVariations.value },
    ];
  }
}
