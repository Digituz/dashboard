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
export class CustomSkuVariationValidator {
  constructor(private productService: ProductsService) {}
  existingSku(sku: string = ''): AsyncValidatorFn {
    return (
      control: AbstractControl
    ): Promise<{ [key: string]: any } | null> | Observable<{ [key: string]: any } | null> => {
      if (isEmptyInputValue(control.value)) {
        console.log('valor null');
        return of(null);
      } else if (control.value === sku) {
        console.log('valor null');
        return of(null);
      } else {
        return control.valueChanges.pipe(
          debounceTime(500),
          take(1),
          switchMap((_) =>
            this.productService
              .loadVariations(control.value)
              .pipe(map((sku) => (sku ? { existingSku: { value: control.value } } : null)))
          )
        );
      }
    };
  }
}
