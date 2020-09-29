import { Injectable } from '@angular/core';
import { IDataProvider, QueryParam, Pagination } from '@app/util/pagination';
import { Inventory } from '@app/inventory/inventory.entity';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { InventoryMovement } from './inventory-movement.entity';
import { tap } from 'rxjs/operators';

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

  xlsExport() {}

  download(path: string, body: Object = {}): Observable<any> {
    path = `${this.INVENTORY_ENDPOINT}/xls`;
    return this.httpClient.get(path, { responseType: 'blob' });
  }

  static createAndDownloadBlobFile(body: any, options: any, filename: any) {
    var blob = new Blob([body], options);
    if (navigator.msSaveBlob) {
      // IE 10+
      navigator.msSaveBlob(blob, filename);
    } else {
      var link = document.createElement('a');
      // Browsers that support HTML5 download attribute
      if (link.download !== undefined) {
        var url = URL.createObjectURL(blob);
        link.setAttribute('href', url);
        link.setAttribute('download', filename);
        link.style.visibility = 'hidden';
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
      }
    }
  }

  //`${this.INVENTORY_ENDPOINT}/xls`
  // return this.httpClient.get(`${this.INVENTORY_ENDPOINT}/sxls`,{responseType:'blob'}).pipe(
  //tap(
  //data => console.log(data),
  //err => console.log(err)
  //)
  //);
}
