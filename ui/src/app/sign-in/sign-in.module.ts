import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ButtonModule } from 'primeng/button';
import { InputTextModule } from 'primeng/inputtext';

import { SignInComponent } from './sign-in.component';
import { ReactiveFormsModule } from '@angular/forms';
import { SignInRoutingModule } from './sign-in-routing.module';

@NgModule({
  declarations: [SignInComponent],
  imports: [CommonModule, ReactiveFormsModule, ButtonModule, InputTextModule, SignInRoutingModule],
})
export class SignInModule {}
