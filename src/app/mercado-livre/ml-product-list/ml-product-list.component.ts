import { Component, OnInit, ViewChild } from '@angular/core';
import { DgzTableComponent } from '@app/@shared/dgz-table/dgz-table.component';
import Product from '@app/products/product.entity';
import { Pagination, QueryParam } from '@app/util/pagination';
import { Observable } from 'rxjs';
import { MenuItem } from 'primeng/api';
import { MercadoLivreService } from '../mercado-livre.service';
import MLCategory from '../ml-category.entity';

interface statusOption {
  label: string;
  value: boolean;
}
@Component({
  selector: 'app-ml-product-list',
  templateUrl: './ml-product-list.component.html',
  styleUrls: ['./ml-product-list.component.scss'],
})
export class MLProductListComponent implements OnInit {
  @ViewChild('MLProductsTable') resultsTable: DgzTableComponent<any>;
  queryParams: QueryParam[] = [];
  query: string;
  categories: MLCategory[] = [];
  category: MLCategory;
  statusOptions: statusOption[] = [
    { label: 'Todos', value: null },
    { label: 'Sincronizado', value: true },
    { label: 'Falha', value: false },
  ];
  items: MenuItem[];
  activeItem: MenuItem;

  status: statusOption;

  constructor(private mercadoLivreService: MercadoLivreService) {}

  ngOnInit(): void {
    this.items = [
      { label: 'Lista', icon: 'pi pi-fw pi-list', routerLink: '/mercado-livre/list' },
      { label: 'Erros', icon: 'pi pi-fw pi-exclamation-triangle', routerLink: '/mercado-livre/error-list' },
    ];
    this.activeItem = this.items[0];
  }

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean,
    queryParams?: QueryParam[]
  ): Observable<Pagination<Product>> {
    return this.mercadoLivreService.loadData(pageNumber, pageSize, sortedBy, sortDirectionAscending, queryParams);
  }

  queryProducts() {
    this.queryParams = [
      { key: 'query', value: this.query },
      { key: 'status', value: this.status.value },
    ];
    this.resultsTable.reload(this.queryParams);
  }

  updateQueryParams(queryParams: QueryParam[]) {
    this.query = queryParams?.find((q) => q.key === 'query')?.value.toString();
  }

  resetFilter() {
    this.query = '';
    return localStorage.removeItem('mercado-livre-list');
  }

  search(event: any) {
    this.mercadoLivreService.findCategories(event.query).subscribe((categories: any) => {
      this.categories = categories;
    });
  }

  saveProducts() {
    const products = this.resultsTable.currentData;
    const filterProducts = products
      .filter((product) => product.isChecked === true)
      .map((product) => {
        return { id: product.id, mlId: product.MLProduct.id };
      });
    const category: MLCategory = { id: this.category.category_id, name: this.category.category_name };
    this.mercadoLivreService.saveAll(filterProducts, category).subscribe();
  }
}
