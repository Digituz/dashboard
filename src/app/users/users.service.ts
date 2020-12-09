import { HttpClient } from '@angular/common/http';
import decode from 'jwt-decode';
import { Injectable } from '@angular/core';
import { User } from './user.entity';

@Injectable({
  providedIn: 'root',
})
export class UsersService {
  USER_ENDPOINT = '/users';
  token: any;
  constructor(private httpClient: HttpClient) {
    this.token = localStorage.getItem('digituz-at-local');
  }

  getUserInfo() {
    const { username }: any = decode(this.token);
    return this.httpClient.get<User>(`${this.USER_ENDPOINT}?email=${username}`);
  }

  updateUser(user: User) {
    return this.httpClient.put<User>(`${this.USER_ENDPOINT}`, user);
  }
}
