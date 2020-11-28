import { Component, OnInit, ViewChild } from '@angular/core';
import { DgzTableComponent } from '@app/@shared/dgz-table/dgz-table.component';
import { Pagination, QueryParam } from '@app/util/pagination';
import { Observable } from 'rxjs';
import { PurchaseOrder } from '../purchase-order.entity';
import { PurchaseOrdersService } from '../purchase-orders.service';
import { ConfirmationService } from 'primeng/api';
import { PurchaseOrderStatus } from '../purchase-orders.enum';
import { format } from 'date-fns';

@Component({
  selector: 'app-purchase-orders-list',
  templateUrl: './purchase-orders-list.component.html',
  styleUrls: ['./purchase-orders-list.component.scss'],
  providers: [ConfirmationService],
})
export class PurchaseOrdersListComponent implements OnInit {
  @ViewChild('purchaseOrderTable') resultsTable: DgzTableComponent<PurchaseOrder>;
  queryParams: QueryParam[] = [];
  loading: boolean = true;
  query: string;

  constructor(private purchaseOrdersService: PurchaseOrdersService, private confirmationService: ConfirmationService) {}

  ngOnInit(): void {}

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean,
    queryParams?: QueryParam[]
  ): Observable<Pagination<PurchaseOrder>> {
    return this.purchaseOrdersService.loadData(pageNumber, pageSize, sortedBy, sortDirectionAscending, queryParams);
  }

  querySupplier() {
    this.queryParams = [{ key: 'query', value: this.query }];
    this.resultsTable.reload(this.queryParams);
  }

  updateQueryParams(queryParams: QueryParam[]) {
    this.query = queryParams.find((q) => q.key === 'query')?.value.toString();
  }

  resetFilter() {
    this.query = '';
    return localStorage.removeItem('purchase-order-list');
  }

  updateStatus(order: PurchaseOrder, status: PurchaseOrderStatus) {
    order.changingStatus = true;
    if (status === PurchaseOrderStatus.COMPLETED) {
      const header = 'Marcar pedido de compra como recebido?';
      const message =
        '<p>Ao marcar um pedido como recebido, novas movimentações serão criadas para incrementar o estoque dos itens vinculados ao pedido.</p>' +
        '<p>Tem certeza que deseja realizar essa alteração?</p>';
      return this.askConfirmation(order, status, header, message);
    } else if (order.status === PurchaseOrderStatus.COMPLETED) {
      const header = 'Alterar status da ordem de compra?';
      const message =
        '<p>Ao alterar o status da compra, todas as movimentações de estoque desta compra serão apagadas.</p>' +
        '<p>Tem certeza que deseja realizar essa alteração?</p>';
      return this.askConfirmation(order, status, header, message);
    }
    return this.issueUpdateStatusRequest(order, status);
  }

  private askConfirmation(purchaseOrder: PurchaseOrder, status: PurchaseOrderStatus, header: string, message: string) {
    this.confirmationService.confirm({
      message,
      header,
      rejectButtonStyleClass: 'p-button-danger',
      acceptLabel: 'Sim',
      rejectLabel: 'Não',
      accept: () => this.issueUpdateStatusRequest(purchaseOrder, status),
      reject: () => delete purchaseOrder.changingStatus,
    });
  }

  private issueUpdateStatusRequest(order: PurchaseOrder, status: PurchaseOrderStatus) {
    const updateStatusDTO = {
      referenceCode: order.referenceCode,
      status,
    };
    const updateStatusHandler = {
      next: () => (order.status = status),
      error: () => delete order.changingStatus,
      complete: () => delete order.changingStatus,
    };
    this.purchaseOrdersService.updateStatus(updateStatusDTO).subscribe(updateStatusHandler);
  }
}
