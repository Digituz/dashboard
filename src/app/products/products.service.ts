import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import Product from './product.entity';
import { Observable } from 'rxjs';
import { IDataProvider, Pagination, QueryParam } from '@app/util/pagination';
import { ProductVariationDetailsDTO } from './product-variation-details.dto';
import { map } from 'rxjs/operators';

@Injectable({
  providedIn: 'root',
})
export class ProductsService implements IDataProvider<Product> {
  private PRODUCTS_ENDPOINT = '/products';
  private copiedProduct: any = undefined;

  constructor(private httpClient: HttpClient) {}

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean,
    queryParams?: QueryParam[]
  ): Observable<Pagination<Product>> {
    let query = `${this.PRODUCTS_ENDPOINT}?page=${pageNumber}&limit=${pageSize}`;

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

    return this.httpClient.get<Pagination<Product>>(query);
  }

  public findProducts(query: string): Observable<Pagination<Product>> {
    return this.httpClient.get<Pagination<Product>>(`${this.PRODUCTS_ENDPOINT}?page=1&limit=10&query=${query}`);
  }

  public findProductVariations(query: string, skipCompositeProducts = false): Observable<ProductVariationDetailsDTO[]> {
    return this.httpClient
      .get<ProductVariationDetailsDTO[]>(
        `${this.PRODUCTS_ENDPOINT}/variations?query=${query}&skip-composite-products=${skipCompositeProducts}`
      )
      .pipe(
        map((variations) => {
          return variations.map((variation) => ({
            ...variation,
            completeDescription: `${variation.sku} - ${variation.title} (${variation.description})`,
          }));
        })
      );
  }

  public saveProduct(product: Product): Observable<void> {
    return this.httpClient.post<void>(this.PRODUCTS_ENDPOINT, {
      ...product,
      productImages: product.productImages?.map((productImage) => ({
        imageId: productImage.image.id,
        order: productImage.order,
      })),
    });
  }

  loadProduct(productId: string) {
    return this.httpClient.get<Product>(`${this.PRODUCTS_ENDPOINT}/${productId}`);
  }

  isSkuAvailable(sku: string, isProductVariation: boolean) {
    return this.httpClient.get<boolean>(
      `${this.PRODUCTS_ENDPOINT}/is-sku-available?sku=${sku}&is-product-variation=${isProductVariation}`
    );
  }

  setCopiedProduct(copiedProduct: any) {
    this.copiedProduct = copiedProduct;
  }

  getCopiedProduct() {
    const copied = this.copiedProduct;
    this.copiedProduct = undefined;
    return copied;
  }
}
