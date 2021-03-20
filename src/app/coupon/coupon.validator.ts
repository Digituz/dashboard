import { Injectable } from '@angular/core';
import { AbstractControl, AsyncValidatorFn } from '@angular/forms';
import { Observable, of } from 'rxjs';
import { debounceTime, map, switchMap, take } from 'rxjs/operators';
import { CouponService } from './coupon.service';

function isEmptyInputValue(value: any): boolean {
  // we don't check for string here so it also works with arrays
  return value === null || value.length === 0;
}

@Injectable({ providedIn: 'root' })
export class CustomCouponValidator {
  constructor(private couponService: CouponService) {}
  existingCode(code: string = ''): AsyncValidatorFn {
    return (
      control: AbstractControl
    ): Promise<{ [key: string]: any } | null> | Observable<{ [key: string]: any } | null> => {
      if (isEmptyInputValue(control.value) || control.value === code) {
        return of(null);
      } else {
        return control.valueChanges.pipe(
          debounceTime(500),
          take(1),
          switchMap(() => {
            return this.couponService
              .isCodeAvailable(control.value)
              .pipe(
                map((code) =>
                  code ? { existingCode: { message: 'Já existe um cupom cadastrado com este código' } } : null
                )
              );
          })
        );
      }
    };
  }
}
