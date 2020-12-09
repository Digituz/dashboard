import { Component, OnInit } from '@angular/core';
import { UsersService } from './users.service';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { User } from './user.entity';
import { SignInService } from '@app/sign-in/sign-in.service';
import { MessagesService } from '@app/messages/messages.service';

@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.scss'],
})
export class UsersComponent {
  formFields: FormGroup;
  loading: boolean = true;
  isDisable: boolean = true;
  user: User;

  constructor(
    private usersService: UsersService,
    private fb: FormBuilder,
    private signInService: SignInService,
    private messagesService: MessagesService
  ) {
    this.usersService.getUserInfo().subscribe((result: any) => {
      this.user = result;
      this.configureFormFields(this.user);
    });
  }

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
    this.formFields.get('email').disable();
    this.isDisable = false;
  }

  submit() {
    if (!this.formFields.valid) {
      this.markAllFieldsAsTouched(this.formFields);
    } else {
      const { password, confirmPassword, email, name } = this.formFields.value;
      if (password !== confirmPassword) {
        this.formFields.controls['password'].setErrors({ incorrect: true });
        this.formFields.controls['confirmPassword'].setErrors({ incorrect: true });
      } else {
        const user = { name, email, password };
        this.usersService.updateUser(user).subscribe(() => {
          this.signInService.refreshToken().subscribe(() => {
            this.messagesService.showInfo('Perfil atualizado com sucesso.');
          });
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
