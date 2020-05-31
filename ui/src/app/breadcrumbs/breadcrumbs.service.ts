import { Injectable } from '@angular/core';
import Breadcrumb from './breadcrumb.entity';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class BreadcrumbsService {
  private homeRoute: Breadcrumb = { label: 'Início', url: '' };
  private breadcrumbs: Breadcrumb[] = [this.homeRoute];
  private breadcrumbsSubject = new BehaviorSubject(this.breadcrumbs);

  constructor() {}

  refreshBreadcrumbs(breadcrumbs: Breadcrumb[]): void {
    this.breadcrumbs = [this.homeRoute, ...breadcrumbs];
    this.breadcrumbsSubject.next(this.breadcrumbs);
  }

  getBreadcrumbsSubject() {
    return this.breadcrumbsSubject;
  }
}
