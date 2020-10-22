import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { Supplier } from '../supplier.entity';
import { SupplierService } from '../supplier.service';

@Component({
  selector: 'app-supplier-form',
  templateUrl: './supplier-form.component.html',
  styleUrls: ['./supplier-form.component.scss'],
})
export class SupplierFormComponent implements OnInit {
  loading: true;
  supplier: Supplier;
  formFields: FormGroup;
  constructor(private supplierService: SupplierService, private fb: FormBuilder) {
    const id = 'new';
    if (id === 'new') {
      this.supplier = {};
      this.configureFormFields(this.supplier);
    } else {
      /* this.supplierService.loadSupplier(id).subscribe((supplier) => {
        this.supplier = supplier;
        this.configureFormFields(supplier);
      }); */
    }
  }

  configureFormFields(supplier: Supplier) {
    this.formFields = this.fb.group({
      cnpj: [supplier.cnpj || ''],
      name: [supplier.name || ''],
    });
  }
  ngOnInit(): void {}

  submit() {
    const supplierFromFields = this.formFields.value;
    console.log(supplierFromFields);
    this.supplierService.createSupplier(supplierFromFields).subscribe();
  }
}
