import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { SignInService } from '@app/sign-in/sign-in.service';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.scss'],
})
export class HeaderComponent implements OnInit {
  menuHidden = true;
  user: { name?: string; image?: string };
  tokenSubscription: Subscription;

  constructor(private router: Router, private signInService: SignInService) {}

  ngOnInit() {
    this.tokenSubscription = this.signInService.userChange.subscribe((user) => {
      this.user = user;
    });
  }

  toggleMenu() {
    this.menuHidden = !this.menuHidden;
  }

  signOut() {
    this.signInService.signOut();
    this.router.navigateByUrl('/');
  }

  async userArea() {
    this.router.navigateByUrl('/users');
  }

  get username(): string | null {
    return null;
  }
}
