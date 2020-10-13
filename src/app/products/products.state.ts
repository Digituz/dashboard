import { Injectable } from '@angular/core';
import { State } from '@ngxs/store';

@State<string[]>({
  name: 'products',
  defaults: [],
})
@Injectable()
export class ProductsState {
  constructor() {}
}
