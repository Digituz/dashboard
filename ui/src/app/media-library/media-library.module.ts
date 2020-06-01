import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MediaLibraryComponent } from './media-library.component';
import { MediaLibraryRoutingModule } from './media-library-routing.module';

@NgModule({
  declarations: [MediaLibraryComponent],
  imports: [
    CommonModule,
    MediaLibraryRoutingModule
  ]
})
export class MediaLibraryModule { }
