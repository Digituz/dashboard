import { Injectable } from '@angular/core';
import { Router, CanActivate } from '@angular/router';
import { SignInService } from './sign-in/sign-in.service';

@Injectable()
export class AuthGuardService implements CanActivate {
  constructor(private signInService: SignInService, public router: Router) {}
  canActivate() {
    if (!this.signInService.isSignedIn()) {
      return this.router.parseUrl('/');
    }
    return true;
  }
}
