import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { SignInService } from './sign-in.service';
import { Router } from '@angular/router';

import { environment } from '@env/environment';

@Component({
  selector: 'app-sign-in',
  templateUrl: './sign-in.component.html',
  styleUrls: ['./sign-in.component.scss'],
})
export class SignInComponent implements OnInit {
  loading = true;
  formFields: FormGroup;

  constructor(private fb: FormBuilder, private signInService: SignInService, private router: Router) {
    const { devUser } = environment;
    this.formFields = this.fb.group({
      username: [devUser?.username || ''],
      password: [devUser?.password || ''],
    });
  }

  ngOnInit() {
    if (this.signInService.isSignedIn()) {
      return this.router.navigateByUrl('home');
    }
    this.loading = false;
  }

  signIn(): void {
    this.signInService.signIn(this.formFields.value).subscribe(() => {
      return this.router.navigateByUrl('home');
    });
  }
}
