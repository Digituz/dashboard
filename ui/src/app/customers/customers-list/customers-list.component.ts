import { Component, OnInit, ViewChild } from '@angular/core';
import { Customer } from '../customer.entity';
import { IDataProvider, QueryParam, Pagination } from '@app/util/pagination';
import { DgzTableComponent } from '@app/@shared/dgz-table/dgz-table.component';
import { BreadcrumbsService } from '@app/breadcrumbs/breadcrumbs.service';
import { Observable } from 'rxjs';
import { CustomersService } from '../customers.service';

@Component({
  selector: 'app-customers-list',
  templateUrl: './customers-list.component.html',
  styleUrls: ['./customers-list.component.scss'],
})
export class CustomersListComponent implements OnInit, IDataProvider<Customer> {
  @ViewChild('customersTable') salesOrdersTable: DgzTableComponent<Customer>;
  queryParams: QueryParam[] = [];
  query: string;

  constructor(private breadcrumbsService: BreadcrumbsService, private customersService: CustomersService) {}

  ngOnInit(): void {
    this.breadcrumbsService.refreshBreadcrumbs('Clientes', [{ label: 'Clientes', url: '/customers' }]);
  }

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean
  ): Observable<Pagination<Customer>> {
    return this.customersService.loadData(pageNumber, pageSize, sortedBy, sortDirectionAscending, this.queryParams);
  }

  queryCustomers() {
    this.queryParams = [{ key: 'query', value: this.query }];
  }
}
