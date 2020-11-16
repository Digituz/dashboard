import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators, ValidatorFn, AbstractControl } from '@angular/forms';
import { Customer } from '../customer.entity';
import { CustomersService } from '../customers.service';
import { Router, ActivatedRoute } from '@angular/router';
import { format, isValid, isAfter, isBefore, addDays, parse } from 'date-fns';

@Component({
  selector: 'app-customers-form',
  templateUrl: './customers-form.component.html',
  styleUrls: ['./customers-form.component.scss'],
})
export class CustomersFormComponent implements OnInit {
  formFields: FormGroup;
  customer: Customer;
  loading: boolean = true;
  display: boolean = false;
  minBirthdayDate = parse('01/01/1900', 'dd/MM/yyyy', new Date());
  maxBirtdayDate = new Date();

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
      //estou fazendo a adição de 1 dia pois por algum motivo estava aparecendo
      //a data com 1 dia subitraido ex: no banco 08/06 no form 07/06
      birthDay = format(addDays(new Date(customer.birthday), 1), 'dd/MM/yyyy');
    }

    this.formFields = this.fb.group({
      cpf: [customer.cpf || '', [Validators.required]],
      name: [customer.name || '', [Validators.required]],
      phoneNumber: [customer.phoneNumber || ''],
      email: [customer.email || '', [Validators.required, Validators.email]],
      birthday: [birthDay || null, this.isValidDate()],
      zipAddress: [customer.zipAddress || '', [Validators.required]],
      state: [customer.state || '', [Validators.required]],
      city: [customer.city || '', [Validators.required]],
      neighborhood: [customer.neighborhood || '', [Validators.required]],
      streetAddress: [customer.streetAddress || '', [Validators.required]],
      streetNumber: [customer.streetNumber || '', [Validators.required]],
      streetNumber2: [customer.streetNumber2 || ''],
    });
    this.loading = false;
  }

  submitCustomer() {
    if (!this.formFields.valid) {
      this.markAllFieldsAsTouched(this.formFields);
    } else {
      const customer = {
        ...this.formFields.value,
        id: this.customer.id,
      };

      if (customer.birthday) {
        customer.birthday = parse(customer.birthday, 'dd/MM/yyyy', new Date());
        customer.birthday = format(customer.birthday, 'yyyy-MM-dd');
      }

      this.customersService.saveCustomer(customer).subscribe(() => {
        this.router.navigate(['/customers']);
      });
    }
  }

  isValidDate(): ValidatorFn {
    return (control: AbstractControl): { [key: string]: any } | null => {
      if (!control.value || !control.value.trim()) return null;

      const date = parse(control.value, 'dd/MM/yyyy', new Date());
      if (isValid(date) && !isAfter(date, this.maxBirtdayDate) && !isBefore(date, this.minBirthdayDate)) {
        return null;
      }
      return { invalidDate: true };
    };
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
