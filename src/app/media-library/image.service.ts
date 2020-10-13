import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Image } from './image.entity';
import { merge, Observable } from 'rxjs';
import Tag from '@app/tags/tag.entity';

@Injectable({
  providedIn: 'root',
})
export class ImageService {
  private IMAGES_ENDPOINT = '/media-library';

  constructor(private httpClient: HttpClient) {}

  public loadImages(page: number): Observable<Image[]> {
    return this.httpClient.get<Image[]>(`${this.IMAGES_ENDPOINT}/?page=${page}`);
  }

  public applyTags(images: Image[], tags: Tag[]): Observable<void> {
    return merge(
      ...images.map((image) => {
        return this.httpClient.post<void>(
          `${this.IMAGES_ENDPOINT}/${image.id}`,
          tags.map((tag) => tag.label)
        );
      })
    );
  }

  public removeTag(image: Image, tag: Tag): Observable<void> {
    return this.httpClient.delete<void>(`${this.IMAGES_ENDPOINT}/${image.id}/tag/${tag.label}`);
  }

  public archiveImages(images: Image[]): Observable<void> {
    return merge(
      ...images.map((image) => {
        return this.httpClient.delete<void>(`${this.IMAGES_ENDPOINT}/${image.id}`);
      })
    );
  }

  public withTags(tagLabel: string): Observable<Image[]> {
    return this.httpClient.get<Image[]>(`${this.IMAGES_ENDPOINT}/with-tag/${tagLabel}`);
  }

  loadImage(id: number) {
    return this.httpClient.get<Image>(`${this.IMAGES_ENDPOINT}/${id}`);
  }
}
