import { Component, OnInit, ViewChild } from '@angular/core';
import { BreadcrumbsService } from '@app/breadcrumbs/breadcrumbs.service';
import { DgzTableComponent } from '@app/@shared/dgz-table/dgz-table.component';
import { SalesOrderDTO } from './sales-order.dto';
import { SalesOrdersService } from './sales-orders.service';
import { IDataProvider, Pagination, QueryParam } from '@app/util/pagination';
import { Observable } from 'rxjs';

interface IsApprovedOption {
  label: string;
  value: string;
}

@Component({
  selector: 'app-sales-orders',
  templateUrl: './sales-orders.component.html',
  styleUrls: ['./sales-orders.component.scss'],
})
export class SalesOrdersComponent implements OnInit, IDataProvider<SalesOrderDTO> {
  @ViewChild('salesOrdersTable') salesOrdersTable: DgzTableComponent<SalesOrderDTO>;
  queryParams: QueryParam[] = [];
  query: string;
  isApprovedOptions: IsApprovedOption[] = [
    { label: "Todas", value: null },
    { label: "Aprovadas", value: "true" },
    { label: "Canceladas", value: "false" },
  ];
  isApproved: IsApprovedOption = this.isApprovedOptions[0];

  constructor(private breadcrumbsService: BreadcrumbsService, private salesOrdersService: SalesOrdersService) {}

  ngOnInit(): void {
    this.breadcrumbsService.refreshBreadcrumbs('Vendas', [{ label: 'Vendas', url: '/sales-orders' }]);
  }

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean
  ): Observable<Pagination<SalesOrderDTO>> {
    return this.salesOrdersService.loadData(pageNumber, pageSize, sortedBy, sortDirectionAscending, this.queryParams);
  }

  querySalesOrders() {
    this.queryParams = [
      { key: 'query', value: this.query },
      { key: 'isApproved', value: this.isApproved.value },
    ];
  }
}
