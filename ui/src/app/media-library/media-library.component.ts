import { Component, OnInit } from '@angular/core';
import { NzMessageService } from 'ng-zorro-antd/message';
import { UploadChangeParam } from 'ng-zorro-antd/upload/interface';
import { BreadcrumbsService } from '@app/breadcrumbs/breadcrumbs.service';

import { Image } from './image.entity';
import { ImageService } from './image.service';
import { NzModalService } from 'ng-zorro-antd/modal';
import { BehaviorSubject, Observable } from 'rxjs';
import { ProductsService } from '@app/products/products.service';
import { map, switchMap, debounceTime } from 'rxjs/operators';
import Product from '@app/products/product.entity';
import { Pagination } from '@app/util/pagination';
import { faSearch, faCheckSquare, faSquare } from '@fortawesome/pro-light-svg-icons';

@Component({
  selector: 'app-media-library',
  templateUrl: './media-library.component.html',
  styleUrls: ['./media-library.component.scss'],
})
export class MediaLibraryComponent implements OnInit {
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

  //icons
  faSearch = faSearch;
  faCheckSquare = faCheckSquare;
  faSquare = faSquare;

  selectedImages: Image[] = [];

  constructor(
    private msg: NzMessageService,
    private breadcrumbsService: BreadcrumbsService,
    private productsService: ProductsService,
    private imageService: ImageService,
    private modalService: NzModalService // although not used, we need it here
  ) {}

  handleChange({ file }: UploadChangeParam): void {
    const { status, uid } = file;
    if (status === 'done') {
      this.imagesBeingUploaded.delete(uid);
    } else if (status === 'error') {
      this.msg.error(`Ocorreu um problema no upload do arquivo ${file.name}`);
    } else {
      this.imagesBeingUploaded.add(uid);
    }
    this.isSpinning = this.imagesBeingUploaded.size > 0;

    if (this.imagesBeingUploaded.size === 0) {
      this.msg.success(`Imagens carregadas com sucesso.`);
      this.reloadImages();
    }
  }

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

  handleCancel(): void {
    this.isModalVisible = false;
    this.modalImage = null;
  }

  onSearch(value: string): void {
    this.isProductListLoading = true;
    this.searchChange$.next(value);
  }
}
