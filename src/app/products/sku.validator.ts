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
  existingSku(isProductVariation: boolean, sku: string = ''): AsyncValidatorFn {
    return (
      control: AbstractControl
    ): Promise<{ [key: string]: any } | null> | Observable<{ [key: string]: any } | null> => {
      if (isEmptyInputValue(control.value) || control.value === sku) {
        return of(null);
      } else {
        return control.valueChanges.pipe(
          debounceTime(500),
          take(1),
          switchMap(() => {
            return this.productService
              .isSkuAvailable(control.value, isProductVariation)
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
