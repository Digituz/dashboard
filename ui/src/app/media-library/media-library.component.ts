import { Component, OnInit, ViewChild } from '@angular/core';
import { BreadcrumbsService } from '@app/breadcrumbs/breadcrumbs.service';

import { FileUpload } from 'primeng/fileupload';

import { Image } from './image.entity';
import { ImageService } from './image.service';
import { BehaviorSubject, Observable } from 'rxjs';
import { ProductsService } from '@app/products/products.service';
import { map, switchMap, debounceTime } from 'rxjs/operators';
import Product from '@app/products/product.entity';
import { Pagination } from '@app/util/pagination';
import { HttpClient } from '@angular/common/http';
import { TagsService } from '@app/tags/tags.service';
import Tag from '@app/tags/tag.entity';

@Component({
  selector: 'app-media-library',
  templateUrl: './media-library.component.html',
  styleUrls: ['./media-library.component.scss'],
})
export class MediaLibraryComponent implements OnInit {
  @ViewChild('uploader') uploader: FileUpload;
  private searchChange$ = new BehaviorSubject('');
  images: Image[];
  isModalVisible = false;
  isSpinning = false;
  isProductListLoading = false;
  isUploading = false;
  modalTitle: string;
  modalImage: string;
  selectedProduct?: string;
  optionList: string[] = [];
  imagesSelectedForUpload: File[] = [];
  selectedTags: Tag[];
  tagsFound: Tag[];

  selectedImage: Image;
  selectedImages: Image[] = [];

  constructor(
    private breadcrumbsService: BreadcrumbsService,
    private productsService: ProductsService,
    private imageService: ImageService,
    private httpClient: HttpClient,
    private tagsService: TagsService
  ) {}

  private reloadImages() {
    this.imageService.loadImages().subscribe((images) => {
      this.images = images;
      this.selectedImages = [];
    });
  }

  ngOnInit(): void {
    this.breadcrumbsService.refreshBreadcrumbs('Imagens', [{ label: 'Imagens', url: '/imagens' }]);
    this.reloadImages();

    const searchProducts = (query: string) => {
      return this.productsService.findProducts(query).pipe(
        map((products: Pagination<Product>) => {
          return products.items.map((item: Product) => `${item.sku} - ${item.title}`);
        })
      );
    };

    const optionList$: Observable<string[]> = this.searchChange$
      .asObservable()
      .pipe(debounceTime(500))
      .pipe(switchMap(searchProducts));

    optionList$.subscribe((data) => {
      this.optionList = data;
      this.isProductListLoading = false;
    });
  }

  showLargeImage(image: Image): void {
    this.isModalVisible = true;
    this.modalTitle = image.originalFilename;
    this.modalImage = image.largeFileURL;
    this.imageService.loadImage(image.id).subscribe((image) => {
      this.selectedImage = image;
    });
  }

  selectImage(image: Image): void {
    this.selectedImages.push(image);
    image.selected = true;
  }

  deselectImage(image: Image): void {
    this.selectedImages = this.selectedImages.filter(
      (selectedImage) => selectedImage.originalFileURL !== image.originalFileURL
    );
    image.selected = false;
  }

  handleOk(): void {
    this.isModalVisible = false;
    this.modalImage = null;
  }

  clearModal(): void {
    this.isModalVisible = false;
    this.modalImage = null;
  }

  onSearch(value: string): void {
    this.isProductListLoading = true;
    this.searchChange$.next(value);
  }

  onCancelFileSelection() {
    this.imagesSelectedForUpload = [];
  }

  onImagesSelected($event: any) {
    this.imagesSelectedForUpload = $event.currentFiles;
  }

  onImageRemoved($event: any) {
    this.imagesSelectedForUpload = this.imagesSelectedForUpload.filter((image: File) => {
      return image.name !== $event.file.name || image.lastModified !== $event.file.lastModified;
    });
  }

  uploadFiles({ files }: any) {
    this.isUploading = true;
    const uploadJobs = files.map((file: File) => {
      return new Promise((res, rej) => {
        const formData: FormData = new FormData();
        formData.append('file', file, file.name);
        this.httpClient.post('/media-library/upload', formData).subscribe(res, rej);
      });
    });
    Promise.all(uploadJobs)
      .then(() => {
        this.uploader.clear();
        this.imagesSelectedForUpload = [];
        this.reloadImages();
        this.isUploading = false;
      })
      .catch((err) => {
        console.log(err);
        this.isUploading = false;
      });
  }

  search(event: any) {
    this.tagsService.findTags(event.query).subscribe((tags) => {
      this.tagsFound = tags;
    });
  }

  applyTags() {
    this.imageService.applyTags(this.selectedImages, this.selectedTags).subscribe(() => {
      this.selectedTags = null;
    });
  }

  removeTag(tag: Tag) {
    this.imageService.removeTag(this.selectedImage, tag).subscribe(() => {
      this.selectedImage.tags = this.selectedImage.tags.filter((imageTag) => imageTag.label !== tag.label);
      this.reloadImages();
    });
  }

  archiveImages() {
    this.imageService.archiveImages(this.selectedImages).subscribe(() => {
      this.reloadImages();
    });
  }
}
