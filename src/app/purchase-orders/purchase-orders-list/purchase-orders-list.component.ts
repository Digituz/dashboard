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

  completedPurchaseOrder(purchaseOrder: PurchaseOrder) {
    purchaseOrder.complete = true;
    purchaseOrder.completionDate = format(new Date(), 'yyyy-MM-dd');
    this.confirmationService.confirm({
      message:
        'Ao alterar o status da ordem de compra o estoque sera incrementado com todos os produtos do peido' +
        '<br><br>Tem certeza que deseja realizar essa alteração?',
      header: 'Alterar status da ordem de compra?',
      rejectButtonStyleClass: 'p-button-danger',
      acceptLabel: 'Alterar',
      rejectLabel: 'Cancelar',
      accept: () => {
        const purchaseOrderUpdatedStatus = {
          referenceCode: purchaseOrder.referenceCode,
          status: PurchaseOrderStatus.COMPLETED,
        };
        this.purchaseOrdersService.updateStatus(purchaseOrderUpdatedStatus).subscribe(() => {
          delete purchaseOrder.complete;
          purchaseOrder.status = purchaseOrderUpdatedStatus.status;
        });
      },
      reject: () => {
        delete purchaseOrder.complete;
      },
    });
  }

  reopenPurchaseOrder(purchaseOrder: PurchaseOrder, status: string) {
    purchaseOrder.completionDate = null;
    const purchaseOrderUpdatedStatus = {
      referenceCode: purchaseOrder.referenceCode,
      status: status === PurchaseOrderStatus.CANCELLED ? PurchaseOrderStatus.CANCELLED : PurchaseOrderStatus.IN_PROCESS,
    };
    this.confirmationService.confirm({
      message:
        'Ao alterar o status da compra todos as movimentações de estoque desta compra serão apagadas' +
        '<br><br>Tem certeza que deseja realizar essa alteração?',
      header: 'Alterar status da ordem de compra?',
      rejectButtonStyleClass: 'p-button-danger',
      acceptLabel: 'Alterar',
      rejectLabel: 'Cancelar',
      accept: () => {
        this.purchaseOrdersService.updateStatus(purchaseOrderUpdatedStatus).subscribe(() => {
          delete purchaseOrder.reopening;
          delete purchaseOrder.inProgress;
          purchaseOrder.status = purchaseOrderUpdatedStatus.status;
        });
      },
      reject: () => {
        delete purchaseOrder.reopening;
        delete purchaseOrder.inProgress;
      },
    });
  }
}
