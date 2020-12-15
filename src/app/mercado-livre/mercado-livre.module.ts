import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MercadoLivreComponent } from './mercado-livre.component';
import { MercadoLivreRoutingModule } from './mercado-livre-routing.module';
import { ButtonModule } from 'primeng/button';
import { MLProductListComponent } from './ml-product-list/ml-product-list.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { InputTextModule } from 'primeng/inputtext';
import { CardModule } from 'primeng/card';
import { CheckboxModule } from 'primeng/checkbox';
import { DialogModule } from 'primeng/dialog';
import { DropdownModule } from 'primeng/dropdown';
import { InputNumberModule } from 'primeng/inputnumber';
import { InputSwitchModule } from 'primeng/inputswitch';
import { AutoCompleteModule } from 'primeng/autocomplete';
import { InputMaskModule } from 'primeng/inputmask';
import { ToggleButtonModule } from 'primeng/togglebutton';

import { SharedModule } from '@app/@shared';
import { MLProductFormComponent } from './ml-product-form/ml-product-form.component';

@NgModule({
  declarations: [MercadoLivreComponent, MLProductListComponent, MLProductFormComponent],
  imports: [
    CommonModule,
    MercadoLivreRoutingModule,
    ButtonModule,
    SharedModule,
    FormsModule,
    ReactiveFormsModule,
    InputTextModule,
    CardModule,
    DropdownModule,
    InputMaskModule,
    InputNumberModule,
    AutoCompleteModule,
    InputSwitchModule,
    CheckboxModule,
    DialogModule,
    ToggleButtonModule,
  ],
})
export class MercadoLivreModule {}
