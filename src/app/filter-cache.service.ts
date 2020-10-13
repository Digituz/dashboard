import { Injectable } from '@angular/core';

export interface AnyObject {
  [key: string]: any;
}

@Injectable({
  providedIn: 'root',
})
export class FilterCacheService {
  constructor() {}

  set(key: string, values: AnyObject) {
    localStorage.setItem(key, JSON.stringify(values));
  }

  get(key: string): AnyObject {
    return JSON.parse(localStorage.getItem(key));
  }
}
