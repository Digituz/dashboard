import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { NzIconModule } from 'ng-zorro-antd/icon';
import { IconDefinition } from '@ant-design/icons-angular';
import { NzButtonModule } from 'ng-zorro-antd/button';
import { NzCardModule } from 'ng-zorro-antd/card';
import { NzGridModule } from 'ng-zorro-antd/grid';
import { NzModalModule } from 'ng-zorro-antd/modal';
import { NzMessageModule } from 'ng-zorro-antd/message';
import { NzSelectModule } from 'ng-zorro-antd/select';
import { NzSkeletonModule } from 'ng-zorro-antd/skeleton';
import { NzSpinModule } from 'ng-zorro-antd/spin';
import { NzSwitchModule } from 'ng-zorro-antd/switch';
import { NzUploadModule } from "ng-zorro-antd/upload";
import { MediaLibraryComponent } from './media-library.component';
import { MediaLibraryRoutingModule } from './media-library-routing.module';

import {
  LoadingOutline,
  PictureOutline,
} from '@ant-design/icons-angular/icons';

const icons: IconDefinition[] = [
  LoadingOutline,
  PictureOutline,
];

@NgModule({
  declarations: [MediaLibraryComponent],
  imports: [
    CommonModule,
    FormsModule,
    NzIconModule.forRoot(icons),
    NzButtonModule,
    NzCardModule,
    NzGridModule,
    NzMessageModule,
    NzModalModule,
    NzSelectModule,
    NzSkeletonModule,
    NzSpinModule,
    NzSwitchModule,
    NzUploadModule,
    MediaLibraryRoutingModule
  ]
})
export class MediaLibraryModule { }
