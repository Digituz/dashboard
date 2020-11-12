import { Injectable } from '@angular/core';
import { AbstractControl, AsyncValidatorFn } from '@angular/forms';
import { Observable, of } from 'rxjs';
import { debounceTime, map, switchMap, take } from 'rxjs/operators';
import { ProductsService } from './products.service';

function isEmptyInputValue(value: any): boolean {
  // we don't check for string here so it also works with arrays
  return value === null || value.length === 0;
}

@Injectable({ providedIn: 'root' })
export class CustomSkuValidator {
  constructor(private productService: ProductsService) {}
  existingSku(isProductVariation: Boolean, sku: string = ''): AsyncValidatorFn {
    return (
      control: AbstractControl
    ): Promise<{ [key: string]: any } | null> | Observable<{ [key: string]: any } | null> => {
      if (isEmptyInputValue(control.value)) {
        return of(null);
      } else if (control.value === sku) {
        return of(null);
      } else {
        return control.valueChanges.pipe(
          debounceTime(500),
          take(1),
          switchMap((_) => {
            if (isProductVariation) {
              return this.productService
                .isSkuAvaliable(control.value, isProductVariation)
                .pipe(
                  map((sku) =>
                    sku ? { existingSku: { message: 'Já existe um produto cadastrado com este SKU' } } : null
                  )
                );
            }
            return this.productService
              .isSkuAvaliable(control.value, false)
              .pipe(
                map((sku) =>
                  sku ? { existingSku: { message: 'Já existe um produto cadastrado com este SKU' } } : null
                )
              );
          })
        );
      }
    };
  }
}
