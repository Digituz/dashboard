import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NzPaginationModule } from 'ng-zorro-antd/pagination';

import { LoaderComponent } from './loader/loader.component';
import { MediumEditorComponent } from './medium-editor/medium-editor.component';
import { DgzTableComponent } from './dgz-table/dgz-table.component';

@NgModule({
  imports: [CommonModule, NzPaginationModule],
  declarations: [LoaderComponent, MediumEditorComponent, DgzTableComponent],
  exports: [LoaderComponent, MediumEditorComponent, DgzTableComponent],
})
export class SharedModule {}
