import { Component, ViewChild } from '@angular/core';
import { format, subMonths, parse } from 'date-fns';
import { DgzTableComponent } from '@app/@shared/dgz-table/dgz-table.component';
import { ComboBoxOption } from '@app/util/combo-box-option.interface';

import { Pagination, QueryParam } from '@app/util/pagination';
import { Observable } from 'rxjs';
import { SalesOrdersService } from '../sales-orders.service';
import { SalesOrderCustomerReport } from './sales-order-customer-report.interface';

@Component({
  selector: 'app-sales-orders-report',
  templateUrl: './sales-orders-report.component.html',
  styleUrls: ['./sales-orders-report.component.scss'],
})
export class SalesOrdersReportComponent {
  @ViewChild('ReportTable') resultsTable: DgzTableComponent<SalesOrderCustomerReport>;
  loading = false;
  startDate: string;
  endDate: string;
  groupByOptions: ComboBoxOption[] = [
    { label: 'Cliente', value: 'CUSTOMER' },
    { label: 'Produto', value: 'PRODUCT' },
  ];
  groupBy = this.groupByOptions[0];
  showWarnig: boolean;
  queryParams: QueryParam[] = [];

  constructor(private salesOrdersService: SalesOrdersService) {
    this.defineDefaultDates();
  }
  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean,
    queryParams?: QueryParam[]
  ): Observable<Pagination<SalesOrderCustomerReport>> {
    if (queryParams === undefined) {
      queryParams = [
        { key: 'startDate', value: this.formatDate(this.startDate) },
        { key: 'endDate', value: this.formatDate(this.endDate) },
        { key: 'groupBy', value: this.groupBy.value },
      ];
    }
    return this.salesOrdersService.loadReport(queryParams);
  }

  private defineDefaultDates() {
    const currentDay = new Date();
    const pastMonthDate = subMonths(currentDay, 1);

    this.startDate = format(pastMonthDate, 'dd/MM/yyyy');
    this.endDate = format(currentDay, 'dd/MM/yyyy');
  }

  updateQueryParams(queryParams: QueryParam[]) {
    this.startDate = queryParams.find((q) => q.key === 'startDate')?.value.toString();
    this.endDate = queryParams.find((q) => q.key === 'endDate')?.value.toString();
    if (!this.startDate || !this.endDate) {
      this.defineDefaultDates();
    } else {
      this.startDate = format(parse(this.startDate, 'yyyy-MM-dd', new Date()), 'dd/MM/yyyy');
      this.endDate = format(parse(this.endDate, 'yyyy-MM-dd', new Date()), 'dd/MM/yyyy');
    }

    const savedGroupBy = queryParams.find((q) => q.key === 'groupBy')?.value.toString();
    this.groupBy = this.groupByOptions.find((o) => o.value === savedGroupBy);
  }

  private formatDate(date: String) {
    const dateRecived = date.split('/');
    return `${dateRecived[2]}-${dateRecived[1]}-${dateRecived[0]}`;
  }

  submitReport() {
    this.loading = true;
    this.showWarnig = false;
    if (this.startDate === '' || this.endDate === '') {
      this.showWarnig = true;
      return;
    }

    this.queryParams = [
      { key: 'startDate', value: this.formatDate(this.startDate) },
      { key: 'endDate', value: this.formatDate(this.endDate) },
      { key: 'groupBy', value: this.groupBy.value },
    ];

    this.loading = false;
    if (this.resultsTable) {
      this.resultsTable.reload(this.queryParams);
    }
  }
}
