import { Component, OnInit } from '@angular/core';
import { BreadcrumbsService } from '@app/breadcrumbs/breadcrumbs.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss'],
})
export class HomeComponent implements OnInit {
  isLoading = false;

  constructor(private breadcrumbsService: BreadcrumbsService) {}

  ngOnInit() {
    this.isLoading = false;
    this.breadcrumbsService.refreshBreadcrumbs('Painel de Controle', []);
  }
}
