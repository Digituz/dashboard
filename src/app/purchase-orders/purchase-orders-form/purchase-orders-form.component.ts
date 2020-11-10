import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, FormArray, Validators, FormControl } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { ProductVariationDetailsDTO } from '@app/products/product-variation-details.dto';
import { ProductsService } from '@app/products/products.service';
import { Supplier } from '@app/supplier/supplier.entity';
import { SupplierService } from '@app/supplier/supplier.service';
import { format } from 'date-fns';
import { PurchaseOrderItem } from '../purchase-order-item.entity';
import { PurchaseOrder } from '../purchase-order.entity';
import { PurchaseOrdersService } from '../purchase-orders.service';

@Component({
  selector: 'app-purchase-orders-form',
  templateUrl: './purchase-orders-form.component.html',
  styleUrls: ['./purchase-orders-form.component.scss'],
})
export class PurchaseOrdersFormComponent implements OnInit {
  purchaseOrder: PurchaseOrder;
  formFields: FormGroup;
  productVariationsSugestion: ProductVariationDetailsDTO[] = [];
  supplierSugestion: Supplier[] = [];
  purchaseOrderItems = new FormArray([]);
  skillsForm: FormGroup;
  loading: boolean = true;
  constructor(
    private fb: FormBuilder,
    private router: Router,
    private route: ActivatedRoute,
    private productService: ProductsService,
    private supplierService: SupplierService,
    private purcahseOrderService: PurchaseOrdersService
  ) {}

  ngOnInit(): void {
    const referenceCode = this.route.snapshot.params.referenceCode;

    if (referenceCode === 'new') {
      this.purchaseOrder = {};
      this.configureFormFields(this.purchaseOrder);
    } else {
      const purchaseOrder = this.purcahseOrderService.loadPurchaseOrder(referenceCode).subscribe((results) => {
        console.log(results);
        const order: PurchaseOrder = {
          creationDate: results.creationDate,
          discount: results.discount,
          referenceCode: results.referenceCode,
          total: results.total,
          shippingPrice: results.shippingPrice,
          supplier: results.supplier,
          items: results.items,
        };
        this.configureFormFields(order);
      });
      console.log(purchaseOrder);
    }
  }

  configureFormFields(purchaseOrder: PurchaseOrder) {
    const itemsField = purchaseOrder.items
      ? this.createItemsPurchaseOrder(purchaseOrder)
      : this.fb.array([this.createItem()], [Validators.required, Validators.minLength(1)]);
    this.formFields = this.fb.group({
      supplier: [purchaseOrder.supplier || ''],
      referenceCode: [purchaseOrder.referenceCode || ''],
      creationDate: [purchaseOrder.creationDate || format(new Date(), 'dd/MM/yyyy')],
      total: [purchaseOrder.total || 0.0],
      discount: [purchaseOrder.discount || 0.0],
      shippingPrice: [purchaseOrder.shippingPrice || 0.0],
      items: itemsField,
    });
    this.loading = false;
  }

  searchProductVariations(event: any) {
    this.productService.findProductVariations(event.query).subscribe((results) => {
      this.productVariationsSugestion = results;
    });
  }

  searchSuppliers(event: any) {
    this.supplierService.loadSuppliers(event.query).subscribe((results) => {
      this.supplierSugestion = results;
    });
  }

  addItem() {
    const newItem = this.createItem();
    const items = this.formFields.get('items') as FormArray;
    items.push(newItem);
  }

  removeItem(index: number) {
    this.purchaseOrderItems.removeAt(index);
  }

  createItem(purchaseOrderItem?: PurchaseOrderItem): FormGroup {
    return this.fb.group({
      productVariation: [purchaseOrderItem.productVariation || null],
      price: [purchaseOrderItem ? purchaseOrderItem.productVariation.sellingPrice : 0],
      amount: [purchaseOrderItem ? purchaseOrderItem.amount : 0],
    });
  }

  selectProductVariation(value: ProductVariationDetailsDTO, index: number) {
    const items = this.formFields.get('items') as FormArray;
    const formGroup = items.at(index) as FormGroup;
    formGroup.patchValue({ price: value.sellingPrice });
    formGroup.patchValue({ discount: 0 });
    formGroup.patchValue({ amount: 1 });
    this.updatePrice();
  }

  updatePrice() {
    const items = this.formFields.get('items') as FormArray;
    let itemsTotal = 0;
    for (let index = 0; index < items.length; index++) {
      const formGroup = items.at(index) as FormGroup;
      const itemValue = formGroup.get('price').value || 0;
      const itemDiscount = this.formFields.get('discount').value || 0;
      const itemAmount = formGroup.get('amount').value;
      itemsTotal += (itemValue - itemDiscount) * itemAmount;
      this.formFields.get('total').setValue(itemsTotal);
    }
  }

  submit() {
    const values = this.formFields.value;
    const supplier = values.supplier;
    const referenceCode = values.referenceCode;
    const creationDate = format(new Date(values.creationDate), 'yyyy-MM-dd');
    const total = values.total;
    const discount = values.discount;
    const shippingPrice = values.shippingPrice;
    const items = values.items.map((item: any) => {
      return {
        amount: item.amount,
        price: item.price,
        productVariation: item.productVariation.id,
      };
    });
    const purchaseOrder: PurchaseOrder = {
      supplier,
      referenceCode,
      creationDate,
      total,
      discount,
      shippingPrice,
      items,
    };
    this.purcahseOrderService.save(purchaseOrder).subscribe(() => {
      this.router.navigate(['/purchase-orders']);
    });
  }

  private createItemsPurchaseOrder(purchaseOrder: PurchaseOrder): FormArray {
    return; /* this.fb.array(
      purchaseOrder.items.map((item) => this.createItem(item)),
      [Validators.required, Validators.minLength(1)]
    ); */
  }
}
