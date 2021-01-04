import { Component, OnInit, ViewChild } from '@angular/core';
import { DgzTableComponent } from '@app/@shared/dgz-table/dgz-table.component';
import Product from '@app/products/product.entity';
import { Pagination, QueryParam } from '@app/util/pagination';
import { MenuItem } from 'primeng/api';
import { Observable } from 'rxjs';
import { MercadoLivreService } from '../mercado-livre.service';

@Component({
  selector: 'app-ml-erros-list',
  templateUrl: './ml-erros-list.component.html',
  styleUrls: ['./ml-erros-list.component.scss'],
})
export class MlErrosListComponent implements OnInit {
  @ViewChild('MLErrosTable') resultsTable: DgzTableComponent<any>;
  items: MenuItem[];
  activeItem: MenuItem;
  constructor(private mercadoLivreService: MercadoLivreService) {}

  ngOnInit(): void {
    this.items = [
      { label: 'Lista', icon: 'pi pi-fw pi-list', routerLink: '/mercado-livre/list' },
      { label: 'Erros', icon: 'pi pi-fw pi-exclamation-triangle', routerLink: '/mercado-livre/error-list' },
    ];
    this.activeItem = this.items[1];
  }

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean,
    queryParams?: QueryParam[]
  ): Observable<Pagination<Product>> {
    return this.mercadoLivreService.loadErrors(pageNumber, pageSize, sortedBy, sortDirectionAscending, queryParams);
  }

  cleanUpErrors() {
    this.mercadoLivreService.cleanUpErrors().subscribe(() => {
      this.resultsTable.reload(null);
    });
  }
}
