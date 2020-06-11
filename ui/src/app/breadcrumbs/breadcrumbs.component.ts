import { Component, OnInit } from '@angular/core';
import Breadcrumb from './breadcrumb.entity';
import { BreadcrumbsService } from './breadcrumbs.service';

@Component({
  selector: 'breadcrumbs',
  templateUrl: './breadcrumbs.component.html',
  styleUrls: ['./breadcrumbs.component.scss'],
})
export class BreadcrumbsComponent implements OnInit {
  static readonly ROUTE_DATA_BREADCRUMB = 'breadcrumb';
  readonly home = { icon: 'pi pi-home', url: 'home' };
  breadcrumbs: Breadcrumb[];
  pageTitle: string;

  constructor(private breadcrumbsService: BreadcrumbsService) {
    this.breadcrumbs = [];
    this.pageTitle = '';
  }

  ngOnInit(): void {
    this.breadcrumbsService.getBreadcrumbsSubject().subscribe(({breadcrumbs, pageTitle}) => {
      this.breadcrumbs = breadcrumbs;
      this.pageTitle = pageTitle;
    });
  }
}
