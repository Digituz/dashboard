import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';

@Component({
  selector: 'app-sign-in',
  templateUrl: './sign-in.component.html',
  styleUrls: ['./sign-in.component.scss']
})
export class SignInComponent implements OnInit {
  formFields: FormGroup;
  loading = false;

  constructor(private fb: FormBuilder) {
    this.formFields = this.fb.group({
      user: [''],
      password: [''],
    });
  }

  ngOnInit(): void {
  }

  signIn(): void {
    alert('here i am');
  }
}
