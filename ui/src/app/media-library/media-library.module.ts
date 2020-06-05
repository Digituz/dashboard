import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NzIconModule } from 'ng-zorro-antd/icon';
import { IconDefinition } from '@ant-design/icons-angular';
import { NzCardModule } from 'ng-zorro-antd/card';
import { NzGridModule } from 'ng-zorro-antd/grid';
import { NzMessageModule } from 'ng-zorro-antd/message';
import { NzUploadModule } from "ng-zorro-antd/upload";
import { MediaLibraryComponent } from './media-library.component';
import { MediaLibraryRoutingModule } from './media-library-routing.module';

import {
  PictureOutline,
} from '@ant-design/icons-angular/icons';

const icons: IconDefinition[] = [
  PictureOutline,
];

@NgModule({
  declarations: [MediaLibraryComponent],
  imports: [
    CommonModule,
    NzIconModule.forRoot(icons),
    NzCardModule,
    NzGridModule,
    NzMessageModule,
    NzUploadModule,
    MediaLibraryRoutingModule
  ]
})
export class MediaLibraryModule { }
