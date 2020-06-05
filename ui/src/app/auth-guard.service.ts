import { Injectable } from '@angular/core';
import { Router, CanActivate } from '@angular/router';

@Injectable()
export class AuthGuardService implements CanActivate {
  constructor(public router: Router) {}
  canActivate() {
    console.log('========================================================');
    return true;
    // return this.router.parseUrl('/sign-in');
  }
}
