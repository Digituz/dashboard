import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Image } from './image.entity';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class ImageService {
  private IMAGES_ENDPOINT = '/media-library';

  constructor(private httpClient: HttpClient) {}

  public loadImages(): Observable<Image[]> {
    return this.httpClient.get<Image[]>(this.IMAGES_ENDPOINT);
  }
}
