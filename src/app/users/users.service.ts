import { HttpClient } from '@angular/common/http';
import decode from 'jwt-decode';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class UsersService {
  token: any;
  constructor(private httpClient: HttpClient) {
    this.token = localStorage.getItem('digituz-at-local');
  }

  async getUserInfo() {
    const { username }: any = decode(this.token);
    return this.httpClient.get(`/users?email=${username}`);
  }
}
