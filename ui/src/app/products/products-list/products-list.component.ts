import { Component, OnInit, ViewChild } from '@angular/core';
import Product from '../product.entity';
import { ProductsService } from '../products.service';
import { DgzTableComponent } from '@app/@shared/dgz-table/dgz-table.component';
import { IDataProvider, Pagination } from '@app/util/pagination';
import { Observable } from 'rxjs';

@Component({
  selector: 'app-products-list',
  templateUrl: './products-list.component.html',
  styleUrls: ['./products-list.component.scss'],
})
export class ProductsListComponent implements OnInit, IDataProvider<Product> {
  @ViewChild('productsTable') appFoo: DgzTableComponent<Product>;
  products: Product[];

  constructor(private productsService: ProductsService) {}

  loadData(pageNumber: number, pageSize: number): Observable<Pagination<Product>> {
    return this.productsService.loadData(pageNumber, pageSize);
  }

  ngOnInit(): void {
  }
}
