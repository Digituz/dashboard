import { Injectable } from '@angular/core';
import { IDataProvider, QueryParam, Pagination } from '@app/util/pagination';
import { Inventory } from '@app/inventory/inventory.entity';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { InventoryMovement } from './inventory-movement.entity';

@Injectable({
  providedIn: 'root',
})
export class InventoryService implements IDataProvider<Inventory> {
  private INVENTORY_ENDPOINT = '/inventory';
  private INVENTORY_MOVEMENT_ENDPOINT = '/inventory/movement';

  constructor(private httpClient: HttpClient) {}

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean,
    queryParams?: QueryParam[]
  ): Observable<Pagination<Inventory>> {
    let query = `${this.INVENTORY_ENDPOINT}?page=${pageNumber}&limit=${pageSize}`;

    if (sortedBy) {
      query += `&sortedBy=${sortedBy}`;
    }
    if (sortDirectionAscending !== undefined) {
      query += `&sortDirectionAscending=${sortDirectionAscending}`;
    }

    queryParams
      .filter((queryParam) => {
        return queryParam !== null && queryParam.value !== null && queryParam.value !== undefined;
      })
      .forEach((queryParam) => {
        query += `&${queryParam.key}=${queryParam.value}`;
      });

    return this.httpClient.get<Pagination<Inventory>>(query);
  }

  public findInventories(query: string): Observable<Pagination<Inventory>> {
    return this.httpClient.get<Pagination<Inventory>>(`${this.INVENTORY_ENDPOINT}?page=1&limit=10&query=${query}`);
  }

  public saveInventory(inventory: Inventory): Observable<void> {
    return this.httpClient.post<void>(this.INVENTORY_ENDPOINT, {
      ...inventory,
    });
  }

  loadInventory(inventoryId: string) {
    return this.httpClient.get<Inventory>(`${this.INVENTORY_ENDPOINT}/${inventoryId}`);
  }

  addMovement(inventoryMovement: InventoryMovement): Observable<void> {
    return this.httpClient.post<void>(this.INVENTORY_MOVEMENT_ENDPOINT, {
      sku: inventoryMovement.productVariation.sku,
      amount: inventoryMovement.amount,
      description: inventoryMovement.description,
    });
  }
}
