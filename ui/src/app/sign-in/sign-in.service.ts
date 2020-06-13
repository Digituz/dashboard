import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Subscription, Observable } from 'rxjs';

@Injectable()
export class SignInService {
  private static SIGN_IN_ENDPOINT = '/sign-in';
  private static tokenStorage = 'digituz-at-local';
  private token: string;

  constructor(private httpClient: HttpClient) {
    this.token = JSON.parse(localStorage.getItem(SignInService.tokenStorage));
  }

  signIn(credentials: { username: string; password: string }): Observable<any> {
    const request = this.httpClient.post<any>(SignInService.SIGN_IN_ENDPOINT, credentials);
    request.subscribe((response) => {
      const { access_token } = response;
      localStorage.setItem(SignInService.tokenStorage, JSON.stringify(access_token));
      this.token = access_token;
    });
    return request;
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
