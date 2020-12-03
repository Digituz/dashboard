import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { SignInService } from '@app/sign-in/sign-in.service';
import { UsersService } from '@app/users/users.service';
import decode from 'jwt-decode';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.scss'],
})
export class HeaderComponent implements OnInit {
  menuHidden = true;
  user: { name: string; image: string };
  constructor(private router: Router, private signInService: SignInService, private usersService: UsersService) {
    const { name, image }: any = decode(this.signInService.getToken());
    this.user = { name, image };
  }

  ngOnInit() {}

  toggleMenu() {
    this.menuHidden = !this.menuHidden;
  }

  signOut() {
    this.signInService.signOut();
    this.router.navigateByUrl('/');
  }

  async routeUserArea() {
    this.router.navigate(['/users']);
  }

  get username(): string | null {
    return null;
  }
}
