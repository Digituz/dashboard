import { Component, OnInit, ViewChild } from '@angular/core';
import { BreadcrumbsService } from '@app/breadcrumbs/breadcrumbs.service';
import { DgzTableComponent } from '@app/@shared/dgz-table/dgz-table.component';
import { SalesOrderDTO } from '@app/sales-orders/sales-order.dto';
import { Pagination, QueryParam } from '@app/util/pagination';
import { Observable } from 'rxjs';
import { HomeService } from './home.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss'],
})
export class HomeComponent implements OnInit {
  @ViewChild('salesOrderTable') resultsTable: DgzTableComponent<SalesOrderDTO>;
  queryParams: QueryParam[] = [];
  query: string;
  data: any;
  isLoading = false;

  constructor(private homeService: HomeService, private breadcrumbsService: BreadcrumbsService) {
    this.data = {
      labels: ['Quinta', 'Sexta', 'Sábado', 'Domingo', 'Segunda', 'Terça', 'Quarta'],
      datasets: [
        {
          label: 'Boleto',
          backgroundColor: '#42A5F5',
          borderColor: '#1E88E5',
          data: [65, 59, 80, 81, 56, 55, 40],
        },
        {
          label: 'Cartão de Crédito',
          backgroundColor: '#9CCC65',
          borderColor: '#7CB342',
          data: [28, 48, 40, 19, 86, 27, 90],
        },
      ],
    };
  }

  ngOnInit() {
    this.isLoading = false;
    this.breadcrumbsService.refreshBreadcrumbs('Painel de Controle', []);
  }

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean,
    queryParams?: QueryParam[]
  ): Observable<Pagination<SalesOrderDTO>> {
    const data = this.homeService.loadData(pageNumber, pageSize, sortedBy, sortDirectionAscending, queryParams);
    return data;
  }

  querySalesOrders() {
    this.queryParams = [{ key: 'query', value: this.query }];
    this.resultsTable.reload(this.queryParams);
  }
}
