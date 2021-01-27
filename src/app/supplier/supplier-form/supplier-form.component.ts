import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { Supplier } from '../supplier.entity';
import { SupplierService } from '../supplier.service';

@Component({
  selector: 'app-supplier-form',
  templateUrl: './supplier-form.component.html',
  styleUrls: ['./supplier-form.component.scss'],
})
export class SupplierFormComponent implements OnInit {
  supplier: Supplier;
  formFields: FormGroup;
  loading: boolean = true;
  activatedButton: boolean = true;
  display: boolean = false;
  constructor(
    private supplierService: SupplierService,
    private fb: FormBuilder,
    private router: Router,
    private route: ActivatedRoute
  ) {}

  ngOnInit(): void {
    const id = this.route.snapshot.params.id;

    if (id === 'new') {
      this.supplier = {};
      this.configureFormFields(this.supplier);
    } else {
      this.supplierService.loadSupplier(id).subscribe((supplier) => {
        this.supplier = supplier;
        this.configureFormFields(supplier);
      });
    }
  }

  configureFormFields(supplier: Supplier) {
    this.formFields = this.fb.group({
      cnpj: [supplier.cnpj || '', [Validators.required]],
      name: [supplier.name || '', [Validators.required]],
    });
    this.loading = false;
  }

  submit() {
    if (!this.formFields.valid) {
      this.markAllFieldsAsTouched(this.formFields);
    } else {
      const supplierFromFields = this.formFields.value;
      supplierFromFields.id = this.supplier.id;
      this.supplierService.createSupplier(supplierFromFields).subscribe(() => {
        this.router.navigate(['/suppliers']);
      });
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
