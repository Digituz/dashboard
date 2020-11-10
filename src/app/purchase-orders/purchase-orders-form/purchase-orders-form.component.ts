import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, FormArray, Validators, FormControl } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { ProductVariationDetailsDTO } from '@app/products/product-variation-details.dto';
import { ProductsService } from '@app/products/products.service';
import { PurchaseOrderItem } from '../purchase-order-item.entity';
import { PurchaseOrder } from '../purchase-order.entity';

@Component({
  selector: 'app-purchase-orders-form',
  templateUrl: './purchase-orders-form.component.html',
  styleUrls: ['./purchase-orders-form.component.scss'],
})
export class PurchaseOrdersFormComponent implements OnInit {
  purchaseOrder: PurchaseOrder;
  formFields: FormGroup;
  productVariations: ProductVariationDetailsDTO[] = [];
  purchaseOrderItems = new FormArray([]);
  skillsForm: FormGroup;
  loading: boolean = true;
  constructor(
    private fb: FormBuilder,
    private router: Router,
    private route: ActivatedRoute,
    private productService: ProductsService
  ) {}

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
      items: this.purchaseOrderItems,
    });
    this.loading = false;
  }

  searchProductVariations(event: any) {
    this.productService.findProductVariations(event.query).subscribe((results) => {
      this.productVariations = results;
    });
  }

  addItem() {
    const group = this.fb.group({
      productVariation: this.productVariations,
      amount: [0],
      price: [0],
    });

    const items = this.formFields.get('items') as FormArray;
    items.push(group);
  }

  removeItem(index: number) {
    this.purchaseOrderItems.removeAt(index);
  }

  selectProductVariation(value: ProductVariationDetailsDTO, index: number) {
    const items = this.formFields.get('items') as FormArray;
    const formGroup = items.at(index) as FormGroup;
    formGroup.patchValue({ price: value.sellingPrice });
    this.updatePrice();
  }

  updatePrice() {
    const items = this.formFields.get('items') as FormArray;
    let itemsTotal = 0;
    for (let index = 0; index < items.length; index++) {
      const formGroup = items.at(index) as FormGroup;
      console.log(formGroup);
      const itemValue = formGroup.get('price').value || 0;
      const itemDiscount = formGroup.get('discount').value || 0;
      const itemAmount = formGroup.get('amount').value;
      itemsTotal += (itemValue - itemDiscount) * itemAmount;
    }
  }

  submit() {
    console.log(this.formFields.value);
    return;
  }
}
