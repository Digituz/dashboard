import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { Customer } from '../customer.entity';
import { CustomersService } from '../customers.service';
import { Router, ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-customers-form',
  templateUrl: './customers-form.component.html',
  styleUrls: ['./customers-form.component.scss'],
})
export class CustomersFormComponent implements OnInit {
  formFields: FormGroup;
  customer: Customer;
  loading: boolean = true;

  constructor(
    private fb: FormBuilder,
    private customersService: CustomersService,
    private router: Router,
    private route: ActivatedRoute
  ) {}

  ngOnInit(): void {
    const id = this.route.snapshot.params.id;

    if (id === 'new') {
      this.customer = {};
      this.configureFormFields(this.customer);
    } else {
      this.customersService.loadCustomer(id).subscribe((customer) => {
        this.customer = customer;
        this.configureFormFields(customer);
      });
    }
  }

  private configureFormFields(customer: Customer) {
    let birthDay: string;
    if (customer.birthday) {
      let customerBirthDay = customer.birthday.toString().split('-');
      birthDay = `${customerBirthDay[2]}/${customerBirthDay[1]}/${customerBirthDay[0]}`;
    }
    this.formFields = this.fb.group({
      cpf: [customer.cpf || ''],
      name: [customer.name || ''],
      phoneNumber: [customer.phoneNumber || ''],
      email: [customer.email || ''],
      birthday: [birthDay || null],
      zipAddress: [customer.zipAddress || ''],
      state: [customer.state || ''],
      city: [customer.city || ''],
      neighborhood: [customer.neighborhood || ''],
      streetAddress: [customer.streetAddress || ''],
      streetNumber: [customer.streetNumber || ''],
      streetNumber2: [customer.streetNumber2 || ''],
    });
    this.loading = false;
  }

  submitCustomer() {
    const customerFormFields = this.formFields.value;
    customerFormFields.id = this.customer.id;

    const birthDayformatToDatabase = customerFormFields.birthday.split('/');
    customerFormFields.birthday = `${birthDayformatToDatabase[2]}-${birthDayformatToDatabase[1]}-${birthDayformatToDatabase[0]}`;

    this.customersService.saveCustomer(customerFormFields).subscribe(() => {
      this.router.navigate(['/customers']);
    });
  }
}
