import { Component, OnInit, ViewChild } from '@angular/core';
import { IDataProvider, QueryParam, Pagination } from '@app/util/pagination';
import { SalesOrderDTO } from '../sales-order.dto';
import { DgzTableComponent } from '@app/@shared/dgz-table/dgz-table.component';
import { ComboBoxOption } from '@app/util/combo-box-option.interface';
import { BreadcrumbsService } from '@app/breadcrumbs/breadcrumbs.service';
import { SalesOrdersService } from '../sales-orders.service';
import { Observable } from 'rxjs';
import { PaymentStatus } from '../payment-status.enum';
import { ConfirmationService } from 'primeng/api';
import { SaleOrderBlingStatus } from '../sale-order-bling-status.enum';

@Component({
  selector: 'app-sales-order-list',
  templateUrl: './sales-order-list.component.html',
  styleUrls: ['./sales-order-list.component.scss'],
  providers: [ConfirmationService],
})
export class SalesOrderListComponent implements OnInit, IDataProvider<SalesOrderDTO> {
  @ViewChild('salesOrdersTable') resultsTable: DgzTableComponent<SalesOrderDTO>;
  queryParams: QueryParam[] = [];
  query: string;
  paymentStatusOptions: ComboBoxOption[] = [
    { label: 'Todas', value: null },
    { label: 'Aprovadas', value: 'APPROVED' },
    { label: 'Canceladas', value: 'CANCELLED' },
    { label: 'Em Processamento', value: 'IN_PROCESS' },
  ];
  paymentStatus: ComboBoxOption = this.paymentStatusOptions[0];

  constructor(
    private breadcrumbsService: BreadcrumbsService,
    private salesOrdersService: SalesOrdersService,
    private confirmationService: ConfirmationService
  ) {}

  ngOnInit(): void {
    this.breadcrumbsService.refreshBreadcrumbs('Vendas', [{ label: 'Vendas', url: '/sales-orders' }]);
  }

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean,
    queryParams?: QueryParam[]
  ): Observable<Pagination<SalesOrderDTO>> {
    return this.salesOrdersService.loadData(pageNumber, pageSize, sortedBy, sortDirectionAscending, queryParams);
  }

  querySalesOrders() {
    this.queryParams = [
      { key: 'query', value: this.query },
      { key: 'paymentStatus', value: this.paymentStatus.value },
    ];
    this.resultsTable.reload(this.queryParams);
  }

  updateQueryParams(queryParams: QueryParam[]) {
    this.query = queryParams.find((q) => q.key === 'query')?.value.toString();

    const selectedPaymentStatusOption = queryParams.find((q) => q.key === 'paymentStatus')?.value;
    if (selectedPaymentStatusOption) {
      this.paymentStatus = this.paymentStatusOptions.find((o) => o.value === selectedPaymentStatusOption);
    }
  }

  syncWithBling(salesOrder: SalesOrderDTO) {
    this.confirmationService.confirm({
      message: 'Deseja realmente sincronizar no Bling?',
      header: 'Sincronizar Venda?',
      acceptButtonStyleClass: 'ui-button-primary',
      rejectButtonStyleClass: 'ui-button-danger',
      acceptLabel: 'Sim',
      rejectLabel: 'Não',
      accept: () => {
        salesOrder.syncingWithBling = true;
        this.salesOrdersService.syncWithBling(salesOrder).subscribe(() => {
          delete salesOrder.syncingWithBling;
          salesOrder.blingStatus = SaleOrderBlingStatus.EM_ABERTO;
        });
      },
    });
  }

  duplicateOrder(salesOrder: SalesOrderDTO) {
    this.confirmationService.confirm({
      message:
        'Deseja duplicar essa venda? Uma nova venda com status de ' +
        'pagamento "Em Processamento" será criada com base na venda selecionada.',
      header: 'Duplicar Venda?',
      acceptButtonStyleClass: 'ui-button-primary',
      rejectButtonStyleClass: 'ui-button-danger',
      acceptLabel: 'Sim',
      rejectLabel: 'Não',
      accept: () => {
        salesOrder.duplicatingSalesOrder = true;
        const newSalesOrder: SalesOrderDTO = {
          ...salesOrder,
          id: null,
          blingStatus: null,
          paymentStatus: PaymentStatus.IN_PROCESS,
          referenceCode: Date.now().toString(),
        };
        this.salesOrdersService.save(newSalesOrder).subscribe(() => {
          delete salesOrder.duplicatingSalesOrder;
          this.resultsTable.loadData();
        });
      },
    });
  }

  cancelOnBling(salesOrder: SalesOrderDTO) {
    this.confirmationService.confirm({
      message: 'Deseja realmente cancelar a venda no Bling?',
      header: 'Cancelar Venda?',
      acceptButtonStyleClass: 'ui-button-primary',
      rejectButtonStyleClass: 'ui-button-danger',
      acceptLabel: 'Sim',
      rejectLabel: 'Não',
      accept: () => {
        salesOrder.cancellingOnBling = true;
        this.salesOrdersService.cancelOnBling(salesOrder).subscribe(() => {
          delete salesOrder.cancellingOnBling;
          salesOrder.paymentStatus = PaymentStatus.CANCELLED;
          salesOrder.blingStatus = SaleOrderBlingStatus.CANCELADO;
        });
      },
    });
  }
}
