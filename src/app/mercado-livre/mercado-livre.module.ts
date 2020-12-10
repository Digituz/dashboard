import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MercadoLivreComponent } from './mercado-livre.component';
import { MercadoLivreRoutingModule } from './mercado-livre-routing.module';
import { ButtonModule } from 'primeng/button';
import { MlProductListComponent } from './ml-product-list/ml-product-list.component';

@NgModule({
  declarations: [MercadoLivreComponent, MlProductListComponent],
  imports: [CommonModule, MercadoLivreRoutingModule, ButtonModule],
})
export class MercadoLivreModule {}
