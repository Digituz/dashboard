import { Component, OnInit } from '@angular/core';
import { MessagesService } from './messages.service';
import { Message, MessageService } from 'primeng/api';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-messages',
  templateUrl: './messages.component.html',
  styleUrls: ['./messages.component.scss'],
  providers: [MessageService],
})
export class MessagesComponent implements OnInit {
  message: Message[] = [];
  messageSubscription: Subscription;
  isUpdate = false;
  constructor(private messagesService: MessagesService, private messageService: MessageService) {}

  ngOnInit(): void {
    this.subscribeToMessageNotifications();
  }

  subscribeToMessageNotifications() {
    this.messageSubscription = this.messagesService.messageNotificationChange.subscribe((notification: Message) => {
      if (notification.severity === 'info') {
        this.isUpdate = true;
        notification.life = 300000;
      } else {
        this.isUpdate = false;
      }
      setTimeout(() => this.messageService.add(notification), 1);
    });
  }

  onSubmit() {
    console.log('aqui');
    window.location.reload();
  }

  onCancel() {
    this.messageService.clear();
  }
}
