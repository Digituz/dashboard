import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Pagination, QueryParam } from '@app/util/pagination';
import { Observable } from 'rxjs';
import { SalesOrderDTO } from '../sales-order.dto';
import { SalesOrdersService } from '../sales-orders.service';

interface Ordination {
  label: string;
  id: number;
}

@Component({
  selector: 'app-sales-orders-report',
  templateUrl: './sales-orders-report.component.html',
  styleUrls: ['./sales-orders-report.component.scss'],
})
export class SalesOrdersReportComponent implements OnInit {
  loading: boolean = false;
  formFields: FormGroup;
  order: Ordination[] = [
    { label: 'Cliente', id: 1 },
    { label: 'Data da Venda', id: 2 },
    { label: 'Data da Aprovação', id: 3 },
    { label: 'Estado', id: 4 },
    { label: 'Valor', id: 5 },
  ];

  constructor(private salesOrdersService: SalesOrdersService, private fb: FormBuilder) {}

  ngOnInit(): void {}

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
    this.formFields = this.fb.group({});
    this.loading = false;
  }
  submitReport() {
    return console.log('form vivo');
  }
}
