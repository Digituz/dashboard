import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ButtonModule } from 'primeng/button';
import { DialogModule } from 'primeng/dialog';

import { LoaderComponent } from './loader/loader.component';
import { MediumEditorComponent } from './medium-editor/medium-editor.component';
import { DgzTableComponent } from './dgz-table/dgz-table.component';
import { DgzSortableDirective } from './dgz-table/dgz-sortable.directive';
import { ReaisPipe } from './pipes/reais.pipe';
import { ButtonBackComponent } from './button-back/button-back.component';
import { CnpjPipe } from './pipes/cnpj.pipe';
import { AlertComponent } from './alert/alert.component';

@NgModule({
  imports: [CommonModule, ButtonModule, DialogModule],
  declarations: [
    LoaderComponent,
    MediumEditorComponent,
    DgzTableComponent,
    DgzSortableDirective,
    ReaisPipe,
    ButtonBackComponent,
    CnpjPipe,
    AlertComponent,
  ],
  exports: [
    LoaderComponent,
    MediumEditorComponent,
    DgzTableComponent,
    DgzSortableDirective,
    ReaisPipe,
    CnpjPipe,
    ButtonBackComponent,
    AlertComponent,
  ],
})
export class SharedModule {}
