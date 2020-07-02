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
  availableImages: Image[] = [];
  selectedImages: Image[] = [];
  productImages: Image[] = [];
  productImagesIds: number[] = [];

  @Output() imagesSelected = new EventEmitter<Image[]>();

  constructor(private imageService: ImageService) {}

  ngOnInit(): void {
    this.productImages = this.product.productImages?.map((productImage) => productImage.image);
    this.productImagesIds = this.productImages?.map((selectedImage) => selectedImage.id);
  }

  openImagesDialog() {
    this.imageService.withTags(this.product.sku).subscribe((availableImages) => {
      this.availableImages = availableImages;
      this.selectedImages = this.availableImages.filter((availableImage) => {
        return this.productImagesIds.includes(availableImage.id);
      });
    });
    this.isModalVisible = true;
  }

  saveProductImages() {
    this.imagesSelected.emit(this.selectedImages);
    this.productImages = this.selectedImages || [];
    this.productImagesIds = this.selectedImages?.map((selectedImage) => selectedImage.id);
    this.closeDialog();
  }

  closeDialog() {
    this.isModalVisible = false;
    this.availableImages = [];
    this.selectedImages = [];
  }
}
