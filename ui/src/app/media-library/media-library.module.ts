import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';

import { MediaLibraryComponent } from './media-library.component';
import { MediaLibraryRoutingModule } from './media-library-routing.module';

@NgModule({
  declarations: [MediaLibraryComponent],
  imports: [
    CommonModule,
    FormsModule,
    FontAwesomeModule,
    MediaLibraryRoutingModule,
  ],
})
export class MediaLibraryModule {}
