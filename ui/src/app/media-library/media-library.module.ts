import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { ButtonModule } from 'primeng/button';
import { DialogModule } from 'primeng/dialog';

import { MediaLibraryComponent } from './media-library.component';
import { MediaLibraryRoutingModule } from './media-library-routing.module';

@NgModule({
  declarations: [MediaLibraryComponent],
  imports: [CommonModule, FormsModule, ButtonModule, DialogModule, MediaLibraryRoutingModule],
})
export class MediaLibraryModule {}
