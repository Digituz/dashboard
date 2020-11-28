import { Injectable } from '@angular/core';
import { HttpEvent, HttpInterceptor, HttpHandler, HttpRequest } from '@angular/common/http';
import { Observable } from 'rxjs';
import { catchError } from 'rxjs/operators';

import { Logger } from '../logger.service';
import { MessagesService } from '../../messages/messages.service';

const log = new Logger('ErrorHandlerInterceptor');

/**
 * Adds a default error handler to all requests.
 */
@Injectable({
  providedIn: 'root',
})
export class ErrorHandlerInterceptor implements HttpInterceptor {
  constructor(private messagesService: MessagesService) {}

  intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    const isValidatingToken = request.url === '/api/v1/refresh-token';
    return next.handle(request).pipe(catchError((error) => this.errorHandler(error, isValidatingToken)));
  }

  private errorHandler(error: any, isValidatingToken: boolean): Observable<HttpEvent<any>> {
    if (error.status !== 401) {
      this.messagesService.showError('Um erro inesperado aconteceu.');
    } else if (!isValidatingToken) {
      this.messagesService.showError('Acesso não permitido.');
    }
    throw error;
  }
}
