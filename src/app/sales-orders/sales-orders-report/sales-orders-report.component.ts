import { Component, ViewChild } from '@angular/core';
import { format, subMonths, parse } from 'date-fns';
import { DgzTableComponent } from '@app/@shared/dgz-table/dgz-table.component';
import { ComboBoxOption } from '@app/util/combo-box-option.interface';
import { Pagination, QueryParam } from '@app/util/pagination';
import { Observable } from 'rxjs';
import { SalesOrdersService } from '../sales-orders.service';
import { SalesOrderCustomerReport } from './sales-order-customer-report.interface';
import { createAndDownloadBlobFile } from '../../util/util';

@Component({
  selector: 'app-sales-orders-report',
  templateUrl: './sales-orders-report.component.html',
  styleUrls: ['./sales-orders-report.component.scss'],
})
export class SalesOrdersReportComponent {
  @ViewChild('resultsTable') resultsTable: DgzTableComponent<any>;
  loading = false;
  startCalendarDate: Date;
  endCalendarDate: Date;
  groupByOptions: ComboBoxOption[] = [
    { label: 'Cliente', value: 'CUSTOMER' },
    { label: 'Produto', value: 'PRODUCT' },
    { label: 'Variação do Produto', value: 'PRODUCT_VARIATION' },
    { label: 'Data de Aprovação', value: 'APPROVAL_DATE' },
  ];
  groupBy = this.groupByOptions[0].value;
  selectedReport: string;
  showWarnig: boolean;
  queryParams: QueryParam[] = [];

  constructor(private salesOrdersService: SalesOrdersService) {
    this.startCalendarDate = subMonths(new Date(), 1);
    this.endCalendarDate = new Date();
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
        { key: 'startDate', value: format(this.startCalendarDate, 'yyyy-MM-dd') },
        { key: 'endDate', value: format(this.endCalendarDate, 'yyyy-MM-dd') },
        { key: 'groupBy', value: this.groupBy },
      ];
    }
    return this.salesOrdersService.loadReport(queryParams);
  }

  private defineDefaultDates() {
    this.startCalendarDate = new Date();
    this.endCalendarDate = subMonths(this.startCalendarDate, 1);
  }

  updateQueryParams(queryParams: QueryParam[]) {
    const startDate = queryParams.find((q) => q.key === 'startDate')?.value.toString();
    const endDate = queryParams.find((q) => q.key === 'endDate')?.value.toString();
    if (!startDate || !endDate) {
      this.defineDefaultDates();
    } else {
      this.startCalendarDate = parse(startDate, 'yyyy-MM-dd', new Date());
      this.endCalendarDate = parse(endDate, 'yyyy-MM-dd', new Date());
    }
    const savedGroupBy = queryParams.find((q) => q.key === 'groupBy')?.value.toString();
    this.groupBy = this.groupByOptions.find((o) => o.value === savedGroupBy).value.toString();
    this.selectedReport = this.groupBy;
  }

  submitReport() {
    this.showWarnig = false;
    if (this.startCalendarDate === null || this.endCalendarDate === null) {
      this.showWarnig = true;
      return;
    }

    this.selectedReport = this.groupBy.toString();

    this.queryParams = [
      { key: 'startDate', value: format(this.startCalendarDate, 'yyyy-MM-dd') },
      { key: 'endDate', value: format(this.endCalendarDate, 'yyyy-MM-dd') },
      { key: 'groupBy', value: this.groupBy },
    ];
    this.loading = false;

    if (this.resultsTable) {
      this.resultsTable.reload(this.queryParams);
    }
  }

  xlsExport() {
    const startDate = format(this.startCalendarDate, 'yyyy-MM-dd');
    const endDate = format(this.endCalendarDate, 'yyyy-MM-dd');
    this.salesOrdersService.download(this.groupBy.toString(), startDate, endDate).subscribe((res) => {
      const options = { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' };
      const filename = 'Vendas.xlsx';
      createAndDownloadBlobFile(res, options, filename);
    });
  }
}
