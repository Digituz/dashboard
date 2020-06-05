import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { SignInService } from '@app/sign-in/sign-in.service';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.scss'],
})
export class HeaderComponent implements OnInit {
  menuHidden = true;

  constructor(private router: Router, private signInService: SignInService) {}

  ngOnInit() {}

  toggleMenu() {
    this.menuHidden = !this.menuHidden;
  }

  signOut() {
    this.signInService.signOut();
    this.router.navigateByUrl('/');
  }

  get username(): string | null {
    return null;
  }
}
