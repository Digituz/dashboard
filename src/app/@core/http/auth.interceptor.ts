import { Injectable } from '@angular/core';
import { SignInService } from '../../sign-in/sign-in.service';
import { HttpEvent, HttpHandler, HttpInterceptor, HttpRequest } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable()
export class AuthInterceptor implements HttpInterceptor {
  constructor(private signInService: SignInService) {}

  intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    request = request.clone({
      setHeaders: {
        Authorization: `Bearer ${this.signInService.getToken()}`,
      },
    });
    return next.handle(request);
  }
}
