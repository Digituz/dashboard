import { Component, OnInit } from '@angular/core';
import { MenuItem } from 'primeng/api';

@Component({
  selector: 'app-ml-erros-list',
  templateUrl: './ml-erros-list.component.html',
  styleUrls: ['./ml-erros-list.component.scss'],
})
export class MlErrosListComponent implements OnInit {
  items: MenuItem[];
  activeItem: MenuItem;
  constructor() {}

  ngOnInit(): void {
    this.items = [
      { label: 'Lista', icon: 'pi pi-fw pi-home', routerLink: '/mercado-livre/list' },
      { label: 'Erros', icon: 'pi pi-fw pi-calendar', routerLink: '/mercado-livre/error-list' },
    ];
    this.activeItem = this.items[1];
  }
}
