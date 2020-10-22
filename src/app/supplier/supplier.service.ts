import { Injectable } from '@angular/core';
import { Supplier } from './supplier.entity';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root',
})
export class SupplierService {
  SUPPLIERS_ENDPOINT = '/suppliers';
  constructor(private httpClient: HttpClient) {}
  loadSupplier(id: string) {}

  createSupplier(supplier: Supplier) {
    return this.httpClient.post<void>(this.SUPPLIERS_ENDPOINT, supplier);
  }
}
