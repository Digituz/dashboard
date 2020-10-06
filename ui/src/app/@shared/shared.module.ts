import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ButtonModule } from 'primeng/button';

import { LoaderComponent } from './loader/loader.component';
import { MediumEditorComponent } from './medium-editor/medium-editor.component';
import { DgzTableComponent } from './dgz-table/dgz-table.component';
import { DgzSortableDirective } from './dgz-table/dgz-sortable.directive';
import { ReaisPipe } from './pipes/reais.pipe';
import { ButtonBackComponent } from './button-back/button-back.component';
import { DialogModule } from 'primeng/dialog';

@NgModule({
  imports: [CommonModule, ButtonModule, DialogModule],
  declarations: [
    LoaderComponent,
    MediumEditorComponent,
    DgzTableComponent,
    DgzSortableDirective,
    ReaisPipe,
    ButtonBackComponent,
  ],
  exports: [
    LoaderComponent,
    MediumEditorComponent,
    DgzTableComponent,
    DgzSortableDirective,
    ReaisPipe,
    ButtonBackComponent,
  ],
})
export class SharedModule {}
