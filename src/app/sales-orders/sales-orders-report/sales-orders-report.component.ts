import { Component, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { format, subMonths } from 'date-fns';
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
export class SalesOrdersReportComponent implements OnInit {
  @ViewChild('customersReportTable') resultsTable: DgzTableComponent<SalesOrderCustomerReport>;
  loading: boolean = true;
  formFields: FormGroup;
  groupBy: ComboBoxOption[] = [
    { label: 'Cliente', value: 'CUSTOMER' },
    { label: 'Produto', value: 'PRODUCT' },
  ];
  showReport: string;
  showWarnig: boolean;
  selectedGroupBy: ComboBoxOption = this.groupBy[0];
  queryParams: QueryParam[] = [];
  query: string;

  constructor(private salesOrdersService: SalesOrdersService, private fb: FormBuilder) {}

  ngOnInit(): void {
    this.configureFormFields();
  }

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean,
    queryParams?: QueryParam[]
  ): Observable<Pagination<SalesOrderCustomerReport>> {
    const formFieldsValues = this.formFields.value;
    const startDate = this.formatDate(formFieldsValues.initialDate);
    const endDate = this.formatDate(formFieldsValues.finalDate);
    const groupBy = this.showReport || 'CUSTOMER';
    return this.salesOrdersService.loadDataGroupBy(
      startDate,
      endDate,
      groupBy,
      pageNumber,
      pageSize,
      sortedBy,
      sortDirectionAscending,
      queryParams
    );
  }

  private configureFormFields() {
    const currentDay = new Date();
    const pastMonthDate = subMonths(currentDay, 1);

    const initalDate = format(pastMonthDate, 'dd/MM/yyyy');
    const finalDate = format(new Date(), 'dd/MM/yyyy');

    this.formFields = this.fb.group({
      initialDate: [initalDate],
      finalDate: [finalDate],
      groupBy: [this.selectedGroupBy.value],
    });
  }

  private formatDate(date: String) {
    const dateRecived = date.split('/');
    return `${dateRecived[2]}-${dateRecived[1]}-${dateRecived[0]}`;
  }

  submitReport() {
    this.loading = true;
    this.showWarnig = false;
    const formValues = this.formFields.value;
    if (formValues.initialDate === '' || formValues.finalDate === '') {
      return (this.showWarnig = true);
    }
    this.showReport = formValues.groupBy;

    this.queryParams = [{ key: 'query', value: this.query }];
    this.loading = false;
    if (this.resultsTable) {
      this.resultsTable.reload(this.queryParams);
    }
  }
}
