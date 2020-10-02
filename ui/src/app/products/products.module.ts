import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { ButtonModule } from 'primeng/button';
import { CardModule } from 'primeng/card';
import { CheckboxModule } from 'primeng/checkbox';
import { DialogModule } from 'primeng/dialog';
import { DropdownModule } from 'primeng/dropdown';
import { InputNumberModule } from 'primeng/inputnumber';
import { InputTextModule } from 'primeng/inputtext';
import { InputSwitchModule } from 'primeng/inputswitch';

import { SharedModule } from '../@shared/shared.module';
import { ProductsRoutingModule } from './products-routing.module';
import { ProductsComponent } from './products.component';
import { ProductFormComponent } from './product-form/product-form.component';
import { ProductImagesComponent } from './product-form/product-images/product-images.component';
import { ProductsListComponent } from './products-list/products-list.component';
import { BreadcrumbsModule } from '@app/breadcrumbs/breadcrumbs.module';
import { ImageService } from '@app/media-library/image.service';
import { TooltipModule } from 'primeng/tooltip';
import { ProductCompositionComponent } from './product-composition/product-composition.component';
import { AutoCompleteModule } from 'primeng/autocomplete';

@NgModule({
  declarations: [
    ProductsComponent,
    ProductFormComponent,
    ProductImagesComponent,
    ProductsListComponent,
    ProductCompositionComponent,
  ],
  imports: [
    FormsModule,
    ReactiveFormsModule,
    SharedModule,
    CommonModule,
    ButtonModule,
    CardModule,
    CheckboxModule,
    DialogModule,
    DropdownModule,
    InputNumberModule,
    InputTextModule,
    InputSwitchModule,
    TooltipModule,
    ProductsRoutingModule,
    BreadcrumbsModule,
    AutoCompleteModule,
  ],
  providers: [ImageService],
})
export class ProductsModule {}
