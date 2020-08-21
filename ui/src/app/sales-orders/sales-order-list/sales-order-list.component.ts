import { Component, OnInit, ViewChild } from '@angular/core';
import { IDataProvider, QueryParam, Pagination } from '@app/util/pagination';
import { SalesOrderDTO } from '../sales-order.dto';
import { DgzTableComponent } from '@app/@shared/dgz-table/dgz-table.component';
import { ComboBoxOption } from '@app/util/combo-box-option.interface';
import { BreadcrumbsService } from '@app/breadcrumbs/breadcrumbs.service';
import { SalesOrdersService } from '../sales-orders.service';
import { Observable } from 'rxjs';

@Component({
  selector: 'app-sales-order-list',
  templateUrl: './sales-order-list.component.html',
  styleUrls: ['./sales-order-list.component.scss'],
})
export class SalesOrderListComponent implements OnInit, IDataProvider<SalesOrderDTO> {
  @ViewChild('salesOrdersTable') salesOrdersTable: DgzTableComponent<SalesOrderDTO>;
  queryParams: QueryParam[] = [];
  query: string;
  paymentStatusOptions: ComboBoxOption[] = [
    { label: 'Todas', value: null },
    { label: 'Aprovadas', value: 'APPROVED' },
    { label: 'Canceladas', value: 'CANCELLED' },
    { label: 'Em Processamento', value: 'IN_PROCESS' },
  ];
  paymentStatus: ComboBoxOption = this.paymentStatusOptions[0];

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
      { key: 'paymentStatus', value: this.paymentStatus.value },
    ];
  }

  syncWithBling(salesOrder: SalesOrderDTO) {
    this.salesOrdersService.syncWithBling(salesOrder).subscribe(() => {
      console.log('done');
    });
  }

  cancelOnBling(salesOrder: SalesOrderDTO) {
    this.salesOrdersService.cancelOnBling(salesOrder).subscribe(() => {
      console.log('done');
    });
  }
}
