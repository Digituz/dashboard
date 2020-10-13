import { AbstractControl } from '@angular/forms';

export function customerValidator(control: AbstractControl): { [key: string]: any } | null {
  if (!control.value) return null;

  const forbiddenResult = { forbiddenName: { value: control.value } };
  if (typeof control.value !== 'object' || !control.value.name || !control.value.cpf) {
    return forbiddenResult;
  }
  return null;
}

export function productItemValidator(control: AbstractControl): { [key: string]: any } | null {
  if (!control.value) return null;

  const forbiddenResult = { forbiddenName: { value: control.value } };
  if (typeof control.value !== 'object' || !control.value.sku) {
    return forbiddenResult;
  }
  return null;
}
