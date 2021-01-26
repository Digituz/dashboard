import { Component, Input, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';

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
  showBarProgress: boolean = true;
  showSuccessRequest: boolean = false;
  showFailedResquest: boolean = false;

  constructor(private router: Router) {
    if (!this.buttonStyle) {
      this.buttonStyle = 'primary';
    }
  }

  ngOnInit(): void {}

  onClick(status?: boolean) {
    this.request.submitTest().subscribe((result: any) => {
      console.log(result);
      this.router.navigate(['/suppliers']);
    });
    this.isModalVisible = true;
    setTimeout(() => {
      this.showBarProgress = false;
      this.showFailedResquest = true;
      setTimeout(() => {
        this.showFailedResquest = false;
        this.showSuccessRequest = true;
      }, 550);
    }, 550);
  }
}
