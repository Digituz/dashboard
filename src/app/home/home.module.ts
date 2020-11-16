import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { TranslateModule } from '@ngx-translate/core';
import { ButtonModule } from 'primeng/button';
import { ChartModule } from 'primeng/chart';
import { TooltipModule } from 'primeng/tooltip';

import { SharedModule } from '@app/@shared';
import { HomeRoutingModule } from './home-routing.module';
import { HomeComponent } from './home.component';

@NgModule({
  imports: [CommonModule, TranslateModule, HomeRoutingModule, SharedModule, ButtonModule, ChartModule, TooltipModule],
  declarations: [HomeComponent],
})
export class HomeModule {}
