import { Component, OnInit } from '@angular/core';
import { NzMessageService } from 'ng-zorro-antd/message';
import { UploadChangeParam } from 'ng-zorro-antd/upload/interface';
import { BreadcrumbsService } from '@app/breadcrumbs/breadcrumbs.service';

import { Image } from './image.entity';
import { ImageService } from './image.service';

@Component({
  selector: 'app-media-library',
  templateUrl: './media-library.component.html',
  styleUrls: ['./media-library.component.scss'],
})
export class MediaLibraryComponent implements OnInit {
  images: Image[];

  constructor(
    private msg: NzMessageService,
    private breadcrumbsService: BreadcrumbsService,
    private imageService: ImageService
  ) {}

  handleChange({ file, fileList }: UploadChangeParam): void {
    const status = file.status;
    if (status !== 'uploading') {
      console.log(file, fileList);
    }
    if (status === 'done') {
      this.msg.success(`${file.name} file uploaded successfully.`);
    } else if (status === 'error') {
      this.msg.error(`${file.name} file upload failed.`);
    }
  }

  ngOnInit(): void {
    this.breadcrumbsService.refreshBreadcrumbs([{ label: 'Imagens', url: '/imagens' }]);
    this.imageService.loadImages().subscribe((images) => {
      this.images = images;
    });
  }
}
