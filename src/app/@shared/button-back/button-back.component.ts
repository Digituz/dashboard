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
    const value: any = this.location.getState();
    if (value.navigationId <= 1) {
      //return this.router.navigateByUrl(this.fallbackURL);
    }
    console.log(value);
    this.location.back();
    this.router.navigate(['/home']);
    setTimeout(() => {
      this.router.navigate([this.fallbackURL]);
      console.log(this.fallbackURL);
    }, 3000);
    return this.router.navigateByUrl(this.fallbackURL);
  }
}
