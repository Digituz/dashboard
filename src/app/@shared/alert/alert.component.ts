import { Component, Input, OnInit, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'app-alert',
  templateUrl: './alert.component.html',
  styleUrls: ['./alert.component.scss'],
})
export class AlertComponent implements OnInit {
  @Input() isModalVisible: boolean;
  @Output() changeVisibilityError = new EventEmitter();
  @Input() errorMessage: string;
  constructor() {}

  ngOnInit(): void {
    console.log(this.errorMessage);
  }
  close() {
    this.changeVisibilityError.emit('false');
    this.isModalVisible = false;
  }
}
