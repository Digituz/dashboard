import { Injectable, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import decode from 'jwt-decode';

@Injectable()
export class SignInService {
  private static SIGN_IN_ENDPOINT = '/sign-in';
  private static tokenStorage = 'digituz-at-local';
  private static tokenInfoStorage = 'digituz-at-info-local';
  private token: string;
  private tokenInfo: { exp?: number };

  constructor(private httpClient: HttpClient) {
    this.token = localStorage.getItem(SignInService.tokenStorage);
    this.tokenInfo = JSON.parse(localStorage.getItem(SignInService.tokenInfoStorage));
  }

  signIn(credentials: { username: string; password: string }): Observable<any> {
    const request = this.httpClient.post<any>(SignInService.SIGN_IN_ENDPOINT, credentials);
    request.subscribe((response) => {
      const { access_token } = response;
      this.token = access_token;
      this.tokenInfo = decode(this.token);
      localStorage.setItem(SignInService.tokenStorage, this.token);
      localStorage.setItem(SignInService.tokenInfoStorage, JSON.stringify(this.tokenInfo));
    });
    return request;
  }

  signOut() {
    localStorage.removeItem(SignInService.tokenStorage);
    localStorage.removeItem(SignInService.tokenInfoStorage);
    this.token = null;
  }

  isSignedId() {
    const now = Date.now();
    if (!this.token || !this.tokenInfo?.exp) return false;
    return this.tokenInfo.exp * 1000 > now + 120 * 1000;
  }

  getToken() {
    return this.token;
  }
}
