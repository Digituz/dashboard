import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { TranslateModule } from '@ngx-translate/core';
import { ButtonModule } from 'primeng/button';
import { ChartModule } from 'primeng/chart';

import { HomeRoutingModule } from './home-routing.module';
import { HomeComponent } from './home.component';
import { SharedModule } from '@app/@shared';

@NgModule({
  imports: [CommonModule, TranslateModule, HomeRoutingModule, SharedModule, ButtonModule, ChartModule],
  declarations: [HomeComponent],
})
export class HomeModule {}
