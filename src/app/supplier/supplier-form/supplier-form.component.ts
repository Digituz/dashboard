import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
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
      cnpj: [supplier.cnpj || ''],
      name: [supplier.name || ''],
    });
    this.loading = false;
  }

  submit() {
    const supplierFromFields = this.formFields.value;
    supplierFromFields.id = this.supplier.id;
    if (supplierFromFields.cnpj === '' || name === supplierFromFields.name) {
      return (this.display = true);
    }
    this.supplierService.createSupplier(supplierFromFields).subscribe(() => {
      this.router.navigate(['/suppliers']);
    });
  }
}
