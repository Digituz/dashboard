import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { TranslateModule } from '@ngx-translate/core';

import { HomeRoutingModule } from './home-routing.module';
import { HomeComponent } from './home.component';
import { NzButtonModule } from 'ng-zorro-antd/button';

@NgModule({
  imports: [CommonModule, TranslateModule, HomeRoutingModule, NzButtonModule],
  declarations: [HomeComponent],
})
export class HomeModule {}
