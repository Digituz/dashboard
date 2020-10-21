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

  loadImages(page: number, tags?: string): Observable<Image[]> {
    let endpoint = `${this.IMAGES_ENDPOINT}/?page=${page}`;
    if (tags) {
      endpoint += `&tags=${tags}`;
    }
    return this.httpClient.get<Image[]>(endpoint);
  }

  applyTags(images: Image[], tags: Tag[]): Observable<void> {
    return merge(
      ...images.map((image) => {
        return this.httpClient.post<void>(
          `${this.IMAGES_ENDPOINT}/${image.id}`,
          tags.map((tag) => tag.label)
        );
      })
    );
  }

  removeTag(image: Image, tag: Tag): Observable<void> {
    return this.httpClient.delete<void>(`${this.IMAGES_ENDPOINT}/${image.id}/tag/${tag.label}`);
  }

  archiveImages(images: Image[]): Observable<void> {
    return merge(
      ...images.map((image) => {
        return this.httpClient.delete<void>(`${this.IMAGES_ENDPOINT}/${image.id}`);
      })
    );
  }

  withTags(tagLabel: string): Observable<Image[]> {
    return this.httpClient.get<Image[]>(`${this.IMAGES_ENDPOINT}/with-tag/${tagLabel}`);
  }

  loadImage(id: number) {
    return this.httpClient.get<Image>(`${this.IMAGES_ENDPOINT}/${id}`);
  }
}
