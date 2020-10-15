import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ComboBoxOption } from '@app/util/combo-box-option.interface';

import { Pagination, QueryParam } from '@app/util/pagination';
import { Observable } from 'rxjs';
import { SalesOrderDTO } from '../sales-order.dto';
import { SalesOrdersService } from '../sales-orders.service';

@Component({
  selector: 'app-sales-orders-report',
  templateUrl: './sales-orders-report.component.html',
  styleUrls: ['./sales-orders-report.component.scss'],
})
export class SalesOrdersReportComponent implements OnInit {
  loading: boolean = true;
  formFields: FormGroup;
  data: any;
  groupBy: ComboBoxOption[] = [{ label: 'Cliente', value: 'CUSTOMER' }];
  selectedGroupBy: ComboBoxOption = this.groupBy[0];

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
  ): Observable<Pagination<SalesOrderDTO>> {
    return this.salesOrdersService.loadData(pageNumber, pageSize, sortedBy, sortDirectionAscending, queryParams);
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
    const dateStart = this.formatDate(formValues.initialDate);
    const dateEnd = this.formatDate(formValues.finalDate);
    return this.salesOrdersService.loadDataGroupBy(dateStart, dateEnd, formValues.groupBy).subscribe((response) => {
      this.data = response;
      console.log(this.data);
      this.loading = false;
    });
  }
}
