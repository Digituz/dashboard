import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import Tag from './tag.entity';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class TagsService {
  private PRODUCTS_ENDPOINT = '/tags';

  constructor(private httpClient: HttpClient) {}

  public findTags(query: string): Observable<Tag[]> {
    console.log('a 2 - ' + query);
    return this.httpClient.get<Tag[]>(`${this.PRODUCTS_ENDPOINT}?query=${query}`);
  }
}
