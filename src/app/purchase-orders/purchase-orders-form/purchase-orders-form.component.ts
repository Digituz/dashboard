import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { Supplier } from '@app/supplier/supplier.entity';
import { SupplierService } from '@app/supplier/supplier.service';
import { PurchaseOrder } from '../purchase-order.entity';

@Component({
  selector: 'app-purchase-orders-form',
  templateUrl: './purchase-orders-form.component.html',
  styleUrls: ['./purchase-orders-form.component.scss'],
})
export class PurchaseOrdersFormComponent implements OnInit {
  purchaseOrder: PurchaseOrder;
  formFields: FormGroup;
  loading: boolean = true;
  constructor(private fb: FormBuilder, private router: Router, private route: ActivatedRoute) {}

  ngOnInit(): void {
    const id = this.route.snapshot.params.referenceCode;

    if (id === 'new') {
      this.purchaseOrder = {};
      this.configureFormFields(this.purchaseOrder);
    } else {
    }
  }

  configureFormFields(purchaseOrder: PurchaseOrder) {
    this.formFields = this.fb.group({
      referenceCode: [purchaseOrder.referenceCode || ''],
      creationDate: [purchaseOrder.creationDate || ''],
      total: [purchaseOrder.total || ''],
      discount: [purchaseOrder.discount || ''],
      shippingPrice: [purchaseOrder.shippingPrice || ''],
      items: [purchaseOrder.items || ''],
    });
    this.loading = false;
  }

  submit() {
    console.log(this.formFields.value);
    return;
  }
}
