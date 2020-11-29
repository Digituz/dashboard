import { Component, OnInit, ViewChild } from '@angular/core';
import { BreadcrumbsService } from '@app/breadcrumbs/breadcrumbs.service';
import { DgzTableComponent } from '@app/@shared/dgz-table/dgz-table.component';
import { SalesOrderDTO } from '@app/sales-orders/sales-order.dto';
import { Pagination, QueryParam } from '@app/util/pagination';
import { Observable } from 'rxjs';
import { HomeService } from './home.service';
import { ShippingType } from '@app/sales-orders/shipping-type.enum';

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
  days: any;

  constructor(private homeService: HomeService, private breadcrumbsService: BreadcrumbsService) {}

  ngOnInit() {
    this.isLoading = false;
    this.breadcrumbsService.refreshBreadcrumbs('Painel de Controle', []);
    this.homeService.loadChartData().subscribe((response) => {
      this.data = response;
    });
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

  getShippingType(shippingType: ShippingType) {
    switch (shippingType) {
      case ShippingType.PAC:
      case ShippingType.SEDEX:
        return shippingType;
      case ShippingType.SAME_DAY:
        return 'EXPRESS';
      default:
        return '???';
    }
  }
}
