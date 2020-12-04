import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { BehaviorSubject, Observable, Subject } from 'rxjs';
import decode from 'jwt-decode';
import { single } from 'rxjs/operators';
import { addMinutes } from 'date-fns';
import { UsersService } from '@app/users/users.service';
import { User } from '@app/users/user.entity';

@Injectable()
export class SignInService {
  private static SIGN_IN_ENDPOINT = '/sign-in';
  private static tokenStorage = 'digituz-at-local';
  private token: string;
  private tokenInfo: { sub?: string; name?: string; image?: string; exp?: number };
  private tokenExpirationDate: Date;
  userChange: Subject<User> = new BehaviorSubject<User>({});

  constructor(private httpClient: HttpClient, private userService: UsersService) {
    this.token = localStorage.getItem(SignInService.tokenStorage);
    if (this.token) {
      this.tokenInfo = decode(this.token);
      this.tokenExpirationDate = new Date(this.tokenInfo.exp * 1000);
    }
    this.handleNewToken = this.handleNewToken.bind(this);
    this.refreshToken = this.refreshToken.bind(this);
    this.signOut = this.signOut.bind(this);
  }

  signIn(credentials: { username: string; password: string }): Observable<any> {
    return this.httpClient.post<any>(SignInService.SIGN_IN_ENDPOINT, credentials).pipe(
      single((response) => {
        return this.handleNewToken(response);
      })
    );
  }

  signOut() {
    localStorage.removeItem(SignInService.tokenStorage);
    this.token = null;
    this.tokenInfo = null;
    this.tokenExpirationDate = null;
  }

  isSignedIn() {
    if (!this.token) return false;
    const thirtyMinutesFromNow = addMinutes(Date.now(), 30);
    return this.tokenExpirationDate > thirtyMinutesFromNow;
  }

  getToken() {
    return this.token;
  }

  refreshToken(): Observable<any> {
    return this.httpClient
      .post<any>(`/refresh-token`, { token: this.token })
      .pipe(single(this.handleNewToken));
  }

  private handleNewToken(response: any) {
    const { access_token } = response;
    this.token = access_token;
    this.tokenInfo = decode(this.token);
    this.tokenExpirationDate = new Date(this.tokenInfo.exp * 1000);
    localStorage.setItem(SignInService.tokenStorage, this.token);
    this.userChange.next({ name: this.tokenInfo.name, email: this.tokenInfo.sub, image: this.tokenInfo.image });

    // if the app stays open, it will refresh the token every three hours
    const threeHours = 3 * 60 * 60 * 1000;
    setTimeout(() => {
      this.refreshToken().subscribe();
    }, threeHours);
    return true;
  }
}
