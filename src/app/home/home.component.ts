import { Component, OnInit, ViewChild } from '@angular/core';
import { BreadcrumbsService } from '@app/breadcrumbs/breadcrumbs.service';
import { DgzTableComponent } from '@app/@shared/dgz-table/dgz-table.component';
import { SalesOrderDTO } from '@app/sales-orders/sales-order.dto';
import { Pagination, QueryParam } from '@app/util/pagination';
import { Observable } from 'rxjs';
import { HomeService } from './home.service';
import { ShippingType } from '@app/sales-orders/shipping-type.enum';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss'],
})
export class HomeComponent implements OnInit {
  @ViewChild('salesOrderTable') resultsTable: DgzTableComponent<SalesOrderDTO>;
  queryParams: QueryParam[] = [];
  query: string;
  threeDaysData: any;
  threeDaysTotal = 0;
  sevenDaysData: any;
  sevenDaysTotal = 0;
  thirtyDaysData: any;
  thirtyDaysTotal = 0;
  isLoading = false;
  days: any;
  chartOptions = {
    legend: {
      display: false,
    },
    tooltips: {
      callbacks: {
        label: (tooltipItem: any) => {
          const total = Math.round(tooltipItem.yLabel * 100) / 100;
          const reais = total.toString().replace('.', ',');
          return `R$ ${reais}`;
        },
      },
    },
    scales: {
      xAxes: [
        {
          ticks: {
            display: false,
          },
        },
      ],
      yAxes: [
        {
          ticks: {
            display: false,
            beginAtZero: true,
          },
        },
      ],
    },
  };

  constructor(private homeService: HomeService, private breadcrumbsService: BreadcrumbsService) {}

  ngOnInit() {
    this.isLoading = false;
    this.breadcrumbsService.refreshBreadcrumbs('Painel de Controle', []);
    this.homeService.loadChartData().subscribe((response: any) => {
      const { threeDaysData, sevenDaysData, thirtyDaysData } = response;
      this.threeDaysData = threeDaysData;
      this.threeDaysTotal = threeDaysData.datasets[0].data.reduce(
        (total: number, current: string) => parseFloat(current) + total,
        0
      );

      this.sevenDaysData = sevenDaysData;
      this.sevenDaysTotal = sevenDaysData.datasets[0].data.reduce(
        (total: number, current: string) => parseFloat(current) + total,
        0
      );

      this.thirtyDaysData = thirtyDaysData;
      this.thirtyDaysTotal = thirtyDaysData.datasets[0].data.reduce(
        (total: number, current: string) => parseFloat(current) + total,
        0
      );
    });
  }

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean,
    queryParams?: QueryParam[]
  ): Observable<Pagination<SalesOrderDTO>> {
    const data = this.homeService.loadData(pageNumber, pageSize, sortedBy, sortDirectionAscending, queryParams);
    return data;
  }

  querySalesOrders() {
    this.queryParams = [{ key: 'query', value: this.query }];
    this.resultsTable.reload(this.queryParams);
  }

  getShippingType(shippingType: ShippingType) {
    switch (shippingType) {
      case ShippingType.PAC:
      case ShippingType.SEDEX:
        return shippingType;
      case ShippingType.SAME_DAY:
        return 'EXPRESS';
      default:
        return '???';
    }
  }
}
