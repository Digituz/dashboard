import { Component, OnInit } from '@angular/core';
import { NzMessageService } from 'ng-zorro-antd/message';
import { UploadChangeParam } from 'ng-zorro-antd/upload/interface';
import { BreadcrumbsService } from '@app/breadcrumbs/breadcrumbs.service';

import { Image } from './image.entity';
import { ImageService } from './image.service';
import { NzModalService } from 'ng-zorro-antd/modal';

@Component({
  selector: 'app-media-library',
  templateUrl: './media-library.component.html',
  styleUrls: ['./media-library.component.scss'],
})
export class MediaLibraryComponent implements OnInit {
  images: Image[];
  isModalVisible = false;
  isSpinning = false;
  modalTitle: string;
  modalImage: string;
  private imagesBeingUploaded = new Set();

  constructor(
    private msg: NzMessageService,
    private breadcrumbsService: BreadcrumbsService,
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

  ngOnInit(): void {
    this.breadcrumbsService.refreshBreadcrumbs([{ label: 'Imagens', url: '/imagens' }]);
    this.reloadImages();
  }

  showModal(image: Image): void {
    this.isModalVisible = true;
    this.modalTitle = image.originalFilename;
    this.modalImage = image.largeFileURL;
  }

  handleOk(): void {
    console.log('click ok');
    this.isModalVisible = false;
  }

  handleCancel(): void {
    this.isModalVisible = false;
  }
}
