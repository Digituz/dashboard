import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'phoneNumber',
})
export class PhoneNumberPipe implements PipeTransform {
  transform(value: string, ...args: any[]): any {
    if (value.length === 11) {
      return value.replace(/(\d{2})(\d{1})(\d{4})(\d{4})/g, '($1) $2 $3-$4');
    }
    if (value.length === 13) {
      return value.replace(/(d\{2})(\d{2})(\d{1})(\d{4})(\d{4})/g, '+$1 ($2) $3 $4-$5');
    }
    return null;
  }
}
