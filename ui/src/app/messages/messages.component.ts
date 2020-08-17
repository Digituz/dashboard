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

  constructor(private messagesService: MessagesService, private messageService: MessageService) {}

  ngOnInit(): void {
    this.subscribeToMessageNotifications();
  }

  subscribeToMessageNotifications() {
    this.messageSubscription = this.messagesService.messageNotificationChange.subscribe((notification: Message) => {
      this.messageService.add(notification);
    });
  }
}
