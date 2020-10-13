import { Injectable } from '@angular/core';
import { Subject } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class MessagesService {
  messageNotificationChange: Subject<Object> = new Subject<Object>();

  showError(error: string) {
    this.messageNotificationChange.next({ severity: 'error', summary: 'Ops!', detail: error, life: 3000 });
  }
}
