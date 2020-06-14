import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NzPaginationModule } from 'ng-zorro-antd/pagination';

import { LoaderComponent } from './loader/loader.component';
import { MediumEditorComponent } from './medium-editor/medium-editor.component';
import { DgzTableComponent } from './dgz-table/dgz-table.component';
import { DgzSortableDirective } from './dgz-table/dgz-sortable.directive';

@NgModule({
  imports: [CommonModule, NzPaginationModule],
  declarations: [LoaderComponent, MediumEditorComponent, DgzTableComponent, DgzSortableDirective],
  exports: [LoaderComponent, MediumEditorComponent, DgzTableComponent, DgzSortableDirective],
})
export class SharedModule {}
