import { Component, Input, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { delay } from 'rxjs/operators';

@Component({
  selector: 'app-load-task-button',
  templateUrl: './load-task-button.component.html',
  styleUrls: ['./load-task-button.component.scss'],
})
export class LoadTaskButtonComponent implements OnInit {
  //para escolher  o estilo do botão basta passar a variavel buttonStyle o final da descrição da
  //clase ex: p-button-secondary buttonStyle='secondary'
  @Input()
  buttonStyle: string = '';
  @Input()
  buttonLabel: string = '';
  @Input()
  request: any;

  isModalVisible: boolean = false;
  showComplete: boolean;
  showSuccessRequest: boolean = false;
  showFailedResquest: boolean = false;

  constructor(private router: Router) {
    if (!this.buttonStyle) {
      this.buttonStyle = 'primary';
    }
  }

  ngOnInit(): void {}

  onClick() {
    this.isModalVisible = true;
    this.request
      .submit()
      .pipe(delay(350))
      .subscribe((result: any) => {
        setTimeout(() => {
          if (result !== null) {
            this.showComplete = true;
          } else {
            this.showComplete = false;
          }
        }, 3000);
      });

    setTimeout(() => (this.isModalVisible = false), 6000);
  }
}
