import { Component, OnInit } from '@angular/core';
import { UsersService } from './users.service';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { User } from './user.entity';
import { SignInService } from '@app/sign-in/sign-in.service';

@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.scss'],
})
export class UsersComponent implements OnInit {
  formFields: FormGroup;
  loading: boolean = true;
  isDisable: boolean = true;
  user: User;
  newToken: string;

  constructor(private usersService: UsersService, private fb: FormBuilder, private signInService: SignInService) {
    this.usersService.getUserInfo().subscribe((result: any) => {
      this.user = result;
      this.configureFormFields(this.user);
    });
  }

  ngOnInit(): void {}

  configureFormFields(user: User) {
    this.formFields = this.fb.group({
      name: [user.name, [Validators.required]],
      email: [user.email],
      password: ['****************'],
      confirmPassword: [null],
    });

    this.formFields.disable();
    this.loading = false;
  }

  enableFields() {
    this.formFields.enable();
    this.formFields.get('password').setValue(null);
    this.isDisable = false;
  }

  submit() {
    if (!this.formFields.valid) {
      this.markAllFieldsAsTouched(this.formFields);
    } else {
      const values = this.formFields.value;
      const password = values.password;
      const confirmPassWOrd = values.confirmPassword;
      const email = values.email;
      const name = values.name;
      if (password !== confirmPassWOrd) {
        this.formFields.controls['password'].setErrors({ incorrect: true });
        this.formFields.controls['confirmPassword'].setErrors({ incorrect: true });
      } else {
        const user = { name, email, password };
        this.usersService.updateUser(user).subscribe((results) => {
          this.signInService.refreshToken().subscribe();
        });
      }
    }
  }

  markAllFieldsAsTouched(formGroup: FormGroup) {
    Object.keys(formGroup.controls).forEach((field) => {
      const control = formGroup.get(field);
      control.markAsTouched({ onlySelf: true });
    });
  }

  isFieldInvalid(field: string) {
    return !this.formFields.get(field).valid && this.formFields.get(field).touched;
  }
}
