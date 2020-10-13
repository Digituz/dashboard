import { Injectable } from '@angular/core';
import Breadcrumb from './breadcrumb.entity';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class BreadcrumbsService {
  private pageTitle: string = '';
  private homeRoute: Breadcrumb = { label: 'Início', url: '' };
  private breadcrumbs: Breadcrumb[] = [this.homeRoute];
  private breadcrumbsSubject = new BehaviorSubject({
    pageTitle: this.pageTitle,
    breadcrumbs: this.breadcrumbs,
  });

  constructor() {}

  refreshBreadcrumbs(pageTitle: string, breadcrumbs: Breadcrumb[]): void {
    this.pageTitle = pageTitle;
    this.breadcrumbs = [this.homeRoute, ...breadcrumbs];
    this.breadcrumbsSubject.next({
      pageTitle: this.pageTitle,
      breadcrumbs: this.breadcrumbs,
    });
  }

  getBreadcrumbsSubject() {
    return this.breadcrumbsSubject;
  }
}
