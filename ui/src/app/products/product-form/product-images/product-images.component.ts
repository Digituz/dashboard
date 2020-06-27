import { Component, Input } from '@angular/core';
import Product from '@app/products/product.entity';
import { Image } from '@app/media-library/image.entity';
import { ImageService } from '@app/media-library/image.service';

@Component({
  selector: 'dgz-product-images',
  templateUrl: './product-images.component.html',
  styleUrls: ['./product-images.component.scss'],
})
export class ProductImagesComponent {
  @Input()
  product: Product;
  isModalVisible: boolean = false;
  images: Image[] = [];
  selectedImages: Image[] = [];

  constructor(
    private imageService: ImageService
  ) {}

  openImagesDialog() {
    this.imageService.withTags(this.product.sku).subscribe((images) => {
      this.images = images;
    });
    this.isModalVisible = true;
  }

  saveProductImages() {}

  closeDialog() {
    this.isModalVisible = false;
  }
}
