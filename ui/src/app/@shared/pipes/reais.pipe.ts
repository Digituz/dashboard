import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'reais',
})
export class ReaisPipe implements PipeTransform {
  transform(value: string | number): string {
    return 'R$ ' + parseFloat(value.toString() || "0").toFixed(2).toString().replace('.', ',');
  }
}
