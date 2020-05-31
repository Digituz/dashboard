import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { LoaderComponent } from './loader/loader.component';
import { MediumEditorComponent } from './medium-editor/medium-editor.component';

@NgModule({
  imports: [CommonModule],
  declarations: [LoaderComponent, MediumEditorComponent],
  exports: [LoaderComponent, MediumEditorComponent],
})
export class SharedModule {}
