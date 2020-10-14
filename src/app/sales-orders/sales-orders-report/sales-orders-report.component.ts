import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-sales-orders-report',
  templateUrl: './sales-orders-report.component.html',
  styleUrls: ['./sales-orders-report.component.scss'],
})
export class SalesOrdersReportComponent implements OnInit {
  constructor() {}

  ngOnInit(): void {
    console.log('cheguei aqui');
  }
}
