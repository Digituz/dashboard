import { Component, Input, OnInit } from '@angular/core';
import { Location } from '@angular/common';
import { Router } from '@angular/router';

@Component({
  selector: 'app-button-back',
  templateUrl: './button-back.component.html',
  styleUrls: ['./button-back.component.scss'],
})
export class ButtonBackComponent implements OnInit {
  @Input()
  fallbackURL = '';

  constructor(private location: Location, private router: Router) {}

  ngOnInit(): void {}

  onClick() {
    const valor: any = this.location.getState();
    if (valor.navigationId <= 1) {
      return this.router.navigateByUrl(this.fallbackURL);
    }
    this.location.back();
  }
}
