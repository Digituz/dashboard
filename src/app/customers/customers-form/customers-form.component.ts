import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
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
  showDialog() {
    this.display = true;
  }
  submitCustomer() {
    const customer = {
      ...this.formFields.value,
      id: this.customer.id,
    };

    customer.birthday = parse(customer.birthday, 'dd/MM/yyyy', new Date());

    if (!this.validateDate(customer.birthday)) {
      this.showDialog();
      return;
    }

    customer.birthday = format(customer.birthday, 'yyyy-MM-dd');

    this.customersService.saveCustomer(customer).subscribe(() => {
      this.router.navigate(['/customers']);
    });
  }

  validateDate(date: string) {
    const dataEmValidacao = new Date(date);
    if (isValid(dataEmValidacao)) {
      if (isAfter(dataEmValidacao, new Date())) {
        this.display = false;
        return false;
      } else if (isBefore(dataEmValidacao, new Date('01/01/1990'))) {
        this.display = false;
        return false;
      } else {
        return true;
      }
    } else {
      this.display = false;
      return false;
    }
  }
}
