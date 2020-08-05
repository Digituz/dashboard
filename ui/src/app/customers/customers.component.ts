import { Component, OnInit } from '@angular/core';
import { BreadcrumbsService } from '@app/breadcrumbs/breadcrumbs.service';

@Component({
  selector: 'app-customers',
  templateUrl: './customers.component.html',
  styleUrls: [],
})
export class CustomersComponent implements OnInit {
  constructor(private breadcrumbsService: BreadcrumbsService) {}

  ngOnInit(): void {
    this.breadcrumbsService.refreshBreadcrumbs('Clientes', [{ label: 'Clientes', url: '/customers' }]);
  }
}
