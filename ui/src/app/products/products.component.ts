import { Component, OnInit } from '@angular/core';
import { BreadcrumbsService } from '@app/breadcrumbs/breadcrumbs.service';

@Component({
  selector: 'app-products',
  templateUrl: './products.component.html',
  styleUrls: ['./products.component.scss'],
})
export class ProductsComponent implements OnInit {
  constructor(private breadcrumbsService: BreadcrumbsService) {}

  ngOnInit(): void {
    this.breadcrumbsService.refreshBreadcrumbs([{ label: 'Produtos', url: '/products' }]);
  }
}
