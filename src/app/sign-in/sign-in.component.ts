import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { SignInService } from './sign-in.service';
import { Router } from '@angular/router';
import { catchError } from 'rxjs/operators';

@Component({
  selector: 'app-sign-in',
  templateUrl: './sign-in.component.html',
  styleUrls: ['./sign-in.component.scss'],
})
export class SignInComponent implements OnInit {
  formFields: FormGroup;
  loading = false;

  constructor(private fb: FormBuilder, private signInService: SignInService, private router: Router) {}

  ngOnInit(): void {
    if (!this.signInService.isSignedIn()) return this.showSignInForm();
    this.loading = true;
    this.signInService
      .refreshToken()
      .pipe(
        catchError((err) => {
          this.showSignInForm();
          return err;
        })
      )
      .subscribe(() => {
        return this.router.navigateByUrl('home');
      });
  }

  signIn(): void {
    this.signInService.signIn(this.formFields.value).subscribe(() => {
      return this.router.navigateByUrl('home');
    });
  }

  private showSignInForm() {
    this.signInService.signOut();
    this.loading = false;
    this.formFields = this.fb.group({
      username: [''],
      password: [''],
    });
  }
}
