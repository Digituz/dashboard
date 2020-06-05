import { Injectable } from '@angular/core';

@Injectable()
export class SignInService {
  private static tokenStorage = 'digituz-at-local';
  private token: string;

  constructor() {
    this.token = localStorage.getItem(SignInService.tokenStorage);
  }

  signIn(username: string, password: string) {
    localStorage.setItem(SignInService.tokenStorage, username + password);
    this.token = username + password;
  }

  signOut() {
    localStorage.removeItem(SignInService.tokenStorage);
    this.token = null;
  }

  isSignedId() {
    return this.token != null;
  }

  getToken() {
    return this.token;
  }
}
