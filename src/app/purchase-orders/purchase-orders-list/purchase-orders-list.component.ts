import { Component, OnInit, ViewChild } from '@angular/core';
import { DgzTableComponent } from '@app/@shared/dgz-table/dgz-table.component';
import { Pagination, QueryParam } from '@app/util/pagination';
import { Observable } from 'rxjs';
import { PurchaseOrder } from '../purchase-order.entity';
import { PurchaseOrdersService } from '../purchase-orders.service';
import { ConfirmationService } from 'primeng/api';
import { PurchaseOrderStatus } from '../purchase-orders.enum';

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

  ngOnInit(): void {
    console.log();
  }

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

  // TODO:
  // 1. Exibir modal explicando o efeito que causa e pedindo confirmação
  // 2. Chamar endpoint específico para reabrir caso o usuário confirme o passo 1
  // Nota: a UI mostra um icone spinning com base numa propriedade chamada 'reopening' que a gente vai adicionar no purchaseOrder
  // Tem lógica similar no cancelar pedido de venda no bling (mas la eu chamei a propriedade de 'cancellingOnBling')

  completedPurchaseOrder(purchaseOrder: PurchaseOrder) {
    this.confirmationService.confirm({
      message:
        'Ao alterar o status da ordem de compra o estoque sera incrementado com todos os produtos do peido' +
        '<br><br>Tem certeza que deseja realizar essa alteração?',
      header: 'Alterar status da ordem de compra?',
      rejectButtonStyleClass: 'p-button-danger',
      acceptLabel: 'Alterar',
      rejectLabel: 'Cancelar',
      accept: () => {
        purchaseOrder.reopening = true;
        const purchaseOrderUpdatedStatus = purchaseOrder;
        purchaseOrderUpdatedStatus.status = PurchaseOrderStatus.COMPLETED;
        this.purchaseOrdersService.updateStatus(purchaseOrder).subscribe(() => {
          delete purchaseOrder.reopening;
          purchaseOrder.status = purchaseOrderUpdatedStatus.status;
        });
      },
    });
  }

  reopenPurchaseOrder(purchaseOrder: PurchaseOrder, status: string) {
    this.confirmationService.confirm({
      message:
        'Ao alterar o status da compra todos as movimentações do estoque serão apagadas' +
        '<br><br>Tem certeza que deseja realizar essa alteração?',
      header: 'Alterar status da ordem de compra?',
      rejectButtonStyleClass: 'p-button-danger',
      acceptLabel: 'Alterar',
      rejectLabel: 'Cancelar',
      accept: () => {
        purchaseOrder.reopening = true;
        const purchaseOrderUpdatedStatus = purchaseOrder;
        if (status === PurchaseOrderStatus.CANCELLED) {
          purchaseOrderUpdatedStatus.status = PurchaseOrderStatus.CANCELLED;
        } else {
          purchaseOrderUpdatedStatus.status = PurchaseOrderStatus.IN_PROCESS;
        }
        this.purchaseOrdersService.updateStatus(purchaseOrderUpdatedStatus).subscribe(() => {
          purchaseOrder.status = purchaseOrderUpdatedStatus.status;
        });
      },
    });
  }
}
