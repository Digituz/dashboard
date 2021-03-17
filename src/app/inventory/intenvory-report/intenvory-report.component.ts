import { Component, OnInit } from '@angular/core';
import { ComboBoxOption } from '@app/util/combo-box-option.interface';

@Component({
  selector: 'app-intenvory-report',
  templateUrl: './intenvory-report.component.html',
  styleUrls: ['./intenvory-report.component.scss'],
})
export class IntenvoryReportComponent implements OnInit {
  groupByOptions: ComboBoxOption[] = [
    { label: 'Cliente', value: 'CUSTOMER' },
    { label: 'Produto', value: 'PRODUCT' },
    { label: 'Variação do Produto', value: 'PRODUCT_VARIATION' },
    { label: 'Data de Aprovação', value: 'APPROVAL_DATE' },
  ];
  groupBy = this.groupByOptions[0].value;

  constructor() {}

  ngOnInit(): void {}
}
