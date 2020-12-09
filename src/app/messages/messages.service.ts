import { Injectable } from '@angular/core';
import { Message } from 'primeng/api';
import { Subject } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class MessagesService {
  messageNotificationChange: Subject<Message> = new Subject<Message>();

  showError(error: string) {
    this.messageNotificationChange.next({ severity: 'error', summary: 'Ops!', detail: error, life: 3000 });
  }

  showInfo(message: string) {
    this.messageNotificationChange.next({ severity: 'info', detail: message, life: 3000 });
  }

  showUpdate() {
    this.messageNotificationChange.next({
      severity: 'info',
      summary: 'Nova Versão',
      detail: 'Lançamos uma nova versão do aplicativo, deseja carregá-la agora?',
      sticky: true,
      data: { update: true },
    });
  }
}
