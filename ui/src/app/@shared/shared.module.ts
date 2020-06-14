import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NzPaginationModule } from 'ng-zorro-antd/pagination';
import { NzSkeletonModule } from 'ng-zorro-antd/skeleton';

import { LoaderComponent } from './loader/loader.component';
import { MediumEditorComponent } from './medium-editor/medium-editor.component';
import { DgzTableComponent } from './dgz-table/dgz-table.component';
import { DgzSortableDirective } from './dgz-table/dgz-sortable.directive';
import { ReaisPipe } from './pipes/reais.pipe';

@NgModule({
  imports: [CommonModule, NzPaginationModule, NzSkeletonModule],
  declarations: [LoaderComponent, MediumEditorComponent, DgzTableComponent, DgzSortableDirective, ReaisPipe],
  exports: [LoaderComponent, MediumEditorComponent, DgzTableComponent, DgzSortableDirective, ReaisPipe],
})
export class SharedModule {}
