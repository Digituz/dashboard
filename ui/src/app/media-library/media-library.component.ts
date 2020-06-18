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

@Component({
  selector: 'app-media-library',
  templateUrl: './media-library.component.html',
  styleUrls: ['./media-library.component.scss'],
})
export class MediaLibraryComponent implements OnInit {
  @ViewChild('uploader') uploader: FileUpload;

  private imagesBeingUploaded = new Set();
  private searchChange$ = new BehaviorSubject('');
  images: Image[];
  isModalVisible = false;
  isSpinning = false;
  isProductListLoading = false;
  showManagementSection = false;
  modalTitle: string;
  modalImage: string;
  selectedProduct?: string;
  optionList: string[] = [];
  imagesSelectedForUpload: File[] = [];

  selectedImages: Image[] = [];

  constructor(
    private breadcrumbsService: BreadcrumbsService,
    private productsService: ProductsService,
    private imageService: ImageService,
    private httpClient: HttpClient
  ) {}

  // handleChange({ file }): void {
  //   const { status, uid } = file;
  //   if (status === 'done') {
  //     this.imagesBeingUploaded.delete(uid);
  //   } else if (status === 'error') {
  //     // this.msg.error(`Ocorreu um problema no upload do arquivo ${file.name}`);
  //   } else {
  //     this.imagesBeingUploaded.add(uid);
  //   }
  //   this.isSpinning = this.imagesBeingUploaded.size > 0;

  //   if (this.imagesBeingUploaded.size === 0) {
  //     this.msg.success(`Imagens carregadas com sucesso.`);
  //     this.reloadImages();
  //   }
  // }

  private reloadImages() {
    this.imageService.loadImages().subscribe((images) => {
      this.images = images;
    });
  }

  toggleManagementSection() {
    this.showManagementSection = !this.showManagementSection;
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

  onImagesSelected($event: any) {
    this.imagesSelectedForUpload = $event.currentFiles;
  }

  onImageRemoved($event: any) {
    this.imagesSelectedForUpload = this.imagesSelectedForUpload.filter((image: File) => {
      return image.name !== $event.file.name || image.lastModified !== $event.file.lastModified;
    });
  }

  uploadFiles({ files }: any) {
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
      })
      .catch((err) => {
        console.log(err);
      });
  }
}
