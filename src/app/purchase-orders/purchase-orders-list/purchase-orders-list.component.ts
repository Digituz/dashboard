import { Component, OnInit, ViewChild } from '@angular/core';
import { DgzTableComponent } from '@app/@shared/dgz-table/dgz-table.component';
import { Pagination, QueryParam } from '@app/util/pagination';
import { Observable } from 'rxjs';
import { PurchaseOrder } from '../purchase-order.entity';
import { PurchaseOrdersService } from '../purchase-orders.service';

@Component({
  selector: 'app-purchase-orders-list',
  templateUrl: './purchase-orders-list.component.html',
  styleUrls: ['./purchase-orders-list.component.scss'],
})
export class PurchaseOrdersListComponent implements OnInit {
  @ViewChild('purchaseOrderTable') resultsTable: DgzTableComponent<PurchaseOrder>;
  queryParams: QueryParam[] = [];
  loading: boolean = true;
  query: string;

  constructor(private purchaseOrdersService: PurchaseOrdersService) {}

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

  reopenPurchaseOrder(purchaseOrder: PurchaseOrder) {
    // TODO:
    // 1. Exibir modal explicando o efeito que causa e pedindo confirmação
    // 2. Chamar endpoint específico para reabrir caso o usuário confirme o passo 1
    // Nota: a UI mostra um icone spinning com base numa propriedade chamada 'reopening' que a gente vai adicionar no purchaseOrder
    // Tem lógica similar no cancelar pedido de venda no bling (mas la eu chamei a propriedade de 'cancellingOnBling')
  }
}
