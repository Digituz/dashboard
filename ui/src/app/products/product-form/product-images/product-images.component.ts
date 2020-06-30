import { Component, Input, Output, EventEmitter, OnInit } from '@angular/core';
import Product from '@app/products/product.entity';
import { Image } from '@app/media-library/image.entity';
import { ImageService } from '@app/media-library/image.service';

@Component({
  selector: 'dgz-product-images',
  templateUrl: './product-images.component.html',
  styleUrls: ['./product-images.component.scss'],
})
export class ProductImagesComponent implements OnInit {
  @Input()
  product: Product;
  isModalVisible: boolean = false;
  images: Image[] = [];
  selectedImages: Image[] = [];

  @Output() imagesSelected = new EventEmitter<Image[]>();

  constructor(private imageService: ImageService) {}

  ngOnInit(): void {
    console.log(this.product);
  }

  openImagesDialog() {
    this.imageService.withTags(this.product.sku).subscribe((images) => {
      this.images = images;
    });
    this.isModalVisible = true;
  }

  saveProductImages() {
    const selectedImages = this.selectedImages;
    this.closeDialog();
    this.imagesSelected.emit(selectedImages);
  }

  closeDialog() {
    this.isModalVisible = false;
    this.product = null;
    this.images = [];
    this.selectedImages = [];
  }
}
