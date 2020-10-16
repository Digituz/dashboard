import { Component, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
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
  customerData: SalesOrderCustomerReport[] = [];
  loading: boolean = true;
  formFields: FormGroup;
  groupBy: ComboBoxOption[] = [
    { label: 'Cliente', value: 'CUSTOMER' },
    { label: 'Produto', value: 'PRODUCT' },
  ];
  showReport: string;
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
    const groupBy = formFieldsValues.groupBy.value;

    const data = this.salesOrdersService.loadDataGroupBy(
      startDate,
      endDate,
      groupBy,
      pageNumber,
      pageSize,
      sortedBy,
      sortDirectionAscending,
      queryParams
    );
    return data;
  }

  private configureFormFields() {
    const currentDay = new Date();
    const day = currentDay.getDate().toString().padStart(2, '0');
    const currentMonth = currentDay.getMonth().toString().padStart(2, '0');
    const pastMonth = (currentDay.getMonth() + 1).toString().padStart(2, '0');
    const year = currentDay.getFullYear();
    const initalDate = day + '/' + currentMonth + '/' + year;
    const finalDate = day + '/' + pastMonth + '/' + year;

    this.formFields = this.fb.group({
      initialDate: [initalDate],
      finalDate: [finalDate],
      groupBy: [this.selectedGroupBy],
    });
  }

  private formatDate(date: String) {
    const dateRecived = date.split('/').reverse();
    return `${dateRecived[0]}-${dateRecived[1]}-${dateRecived[2]}`;
  }

  submitReport() {
    const formValues = this.formFields.value;
    this.showReport = formValues.groupBy;
    console.log(this.showReport);
    this.queryParams = [{ key: 'query', value: this.query }];
    this.resultsTable.reload(this.queryParams);
    this.loading = false;
  }
}
