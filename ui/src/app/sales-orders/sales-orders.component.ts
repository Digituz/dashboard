import { Component, OnInit } from '@angular/core';
import { BreadcrumbsService } from '@app/breadcrumbs/breadcrumbs.service';

@Component({
  selector: 'app-sales-orders',
  templateUrl: './sales-orders.component.html',
  styleUrls: ['./sales-orders.component.scss'],
})
export class SalesOrdersComponent implements OnInit {
  constructor(private breadcrumbsService: BreadcrumbsService) {}

  ngOnInit(): void {
    this.breadcrumbsService.refreshBreadcrumbs('Vendas', [{ label: 'Vendas', url: '/sales-orders' }]);
  }
}
