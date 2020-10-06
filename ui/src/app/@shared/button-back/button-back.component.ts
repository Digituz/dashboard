import { Component, HostListener, OnInit } from '@angular/core';
import { Location } from '@angular/common';
import { Router } from '@angular/router';

@Component({
  selector: 'app-button-back',
  templateUrl: './button-back.component.html',
  styleUrls: ['./button-back.component.scss'],
})
export class ButtonBackComponent implements OnInit {
  isModalVisible: boolean = false;

  constructor(private location: Location, private router: Router) {}

  ngOnInit(): void {}

  @HostListener('click')
  onClick() {
    if (window.history.length <= 2) {
      return (this.isModalVisible = true);
    }
    this.location.back();
  }
}
