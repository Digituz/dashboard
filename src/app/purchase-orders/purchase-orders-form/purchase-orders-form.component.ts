import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, FormArray, Validators, FormControl } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { ProductVariationDetailsDTO } from '@app/products/product-variation-details.dto';
import { ProductsService } from '@app/products/products.service';
import { Supplier } from '@app/supplier/supplier.entity';
import { SupplierService } from '@app/supplier/supplier.service';
import { ComboBoxOption } from '@app/util/combo-box-option.interface';
import { format } from 'date-fns';
import { PurchaseOrderItem } from '../purchase-order-item.entity';
import { PurchaseOrder } from '../purchase-order.entity';
import { PurchaseOrdersService } from '../purchase-orders.service';
import { PurchaseOrderStatus } from '../purchase-orders.enum';

@Component({
  selector: 'app-purchase-orders-form',
  templateUrl: './purchase-orders-form.component.html',
  styleUrls: ['./purchase-orders-form.component.scss'],
})
export class PurchaseOrdersFormComponent implements OnInit {
  purchaseOrder: PurchaseOrder;
  formFields: FormGroup;
  productVariationsSugestion: ProductVariationDetailsDTO[] = [];
  supplierSuggestion: Supplier[] = [];
  loading = true;
  id: any;
  allowsUpdate = true;

  purchaseOrderStatus: ComboBoxOption[] = [
    { label: 'Em Processamento', value: PurchaseOrderStatus.IN_PROCESS },
    { label: 'Recebido', value: PurchaseOrderStatus.COMPLETED },
    { label: 'Cancelado', value: PurchaseOrderStatus.CANCELLED },
  ];

  constructor(
    private fb: FormBuilder,
    private router: Router,
    private route: ActivatedRoute,
    private productService: ProductsService,
    private supplierService: SupplierService,
    private purchaseOrderService: PurchaseOrdersService
  ) {}

  ngOnInit(): void {
    this.id = this.route.snapshot.params.id;

    if (this.id === 'new') {
      this.id = null;
      this.purchaseOrder = {};
      this.configureFormFields(this.purchaseOrder);
    } else {
      this.purchaseOrderService.loadPurchaseOrder(this.id).subscribe((results) => {
        this.purchaseOrder = {
          ...results,
          creationDate: format(new Date(results.creationDate), 'dd/MM/yyyy'),
          completionDate: results.completionDate ? format(new Date(results.completionDate), 'dd/MM/yyyy') : null,
        };
        this.configureFormFields(this.purchaseOrder);
        if (this.purchaseOrder.status === PurchaseOrderStatus.COMPLETED) {
          this.formFields.disable();
          this.allowsUpdate = false;
        }
      });
    }
  }

  configureFormFields(purchaseOrder: PurchaseOrder) {
    const itemsField = purchaseOrder.items
      ? this.createItemsPurchaseOrder(purchaseOrder)
      : this.fb.array([this.createItem()], [Validators.required, Validators.minLength(1)]);
    this.formFields = this.fb.group({
      supplier: [purchaseOrder.supplier || '', [Validators.required]],
      referenceCode: [purchaseOrder.referenceCode || '', [Validators.required]],
      creationDate: [purchaseOrder.creationDate || format(new Date(), 'dd/MM/yyyy')],
      completionDate: [purchaseOrder.completionDate || null],
      total: [purchaseOrder.total || 0.0, [Validators.required]],
      discount: [purchaseOrder.discount || 0.0],
      shippingPrice: [purchaseOrder.shippingPrice || 0.0],
      items: itemsField,
      status: [purchaseOrder.status || PurchaseOrderStatus.IN_PROCESS, [Validators.required]],
    });
    this.loading = false;
  }

  addItem() {
    this.items.push(this.createItem());
  }

  removeItem(index: number) {
    this.items.removeAt(index);
  }

  createItem(purchaseOrderItem?: PurchaseOrderItem): FormGroup {
    return this.fb.group({
      productVariation: [purchaseOrderItem || null, [Validators.required]],
      price: [purchaseOrderItem?.price || 0, [Validators.required, Validators.min(0.01)]],
      amount: [purchaseOrderItem?.amount || 0, [Validators.required, Validators.min(1)]],
    });
  }

  private createItemsPurchaseOrder(purchaseOrder: PurchaseOrder): FormArray {
    return this.fb.array(purchaseOrder.items.map((item) => this.createItem(item)));
  }

  get items(): FormArray {
    return this.formFields.get('items') as FormArray;
  }

  submit() {
    if (!this.formFields.valid) {
      return this.markAllFieldsAsTouched(this.formFields);
    }
    const values = this.formFields.value;
    const supplier = values.supplier;
    const referenceCode = values.referenceCode;
    const creationDate = this.formatDate(values.creationDate);
    const discount = values.discount;
    const status = values.status;
    const shippingPrice = values.shippingPrice;
    const items = values.items.map((item: any) => ({
      productVariation: { sku: item.productVariation.sku, id: item.productVariation.id },
      amount: item.amount,
      price: item.price,
    }));
    const purchaseOrder: PurchaseOrder = {
      id: this.id !== 'new' ? parseInt(this.id) : undefined,
      supplier,
      referenceCode,
      discount,
      shippingPrice,
      items,
      status,
    };
    this.purchaseOrderService.save(purchaseOrder).subscribe(() => {
      this.router.navigate(['/purchase-orders']);
    });
  }

  updatePrice() {
    // order discount and shipping price
    const discount = this.formFields.get('discount').value || 0;
    const shippingPrice = this.formFields.get('shippingPrice').value || 0;

    // items' price total
    const { controls } = this.formFields.get('items') as FormArray;
    const total = controls
      .map(({ value: purchaseOrderItem }) => purchaseOrderItem.price * purchaseOrderItem.amount)
      .reduce((previousAmount, itemAmount) => previousAmount + itemAmount, 0);

    // order's total
    this.formFields.get('total').setValue(total - discount + shippingPrice);
  }

  searchProductVariations(event: any) {
    this.productService.findProductVariations(event.query, true).subscribe((results) => {
      this.productVariationsSugestion = results;
    });
  }

  searchSuppliers(event: any) {
    this.supplierService.loadSuppliers(event.query).subscribe((results) => {
      this.supplierSuggestion = results;
    });
  }

  selectProductVariation(index: number) {
    const items = this.formFields.get('items') as FormArray;
    const formGroup = items.at(index) as FormGroup;
    formGroup.patchValue({ price: 0 });
    formGroup.patchValue({ discount: 0 });
    formGroup.patchValue({ amount: 1 });
    this.updatePrice();
  }

  markAllFieldsAsTouched(formGroup: FormGroup) {
    Object.keys(formGroup.controls).forEach((field) => {
      const control = formGroup.get(field);
      control.markAsTouched({ onlySelf: true });
    });

    const items = formGroup.controls.items as FormArray;
    items?.controls.forEach((group: FormGroup) => this.markAllFieldsAsTouched(group));
  }

  isFieldInvalid(field: string) {
    return !this.formFields.get(field)?.valid && this.formFields.get(field)?.touched;
  }

  isItemFieldInvalid(field: string, index: number) {
    const items = this.formFields.get('items') as FormArray;
    return !items.controls[index].get(field)?.valid && items.controls[index].get(field)?.touched;
  }

  formatDate(date: string) {
    if (!date) return;
    const dateArray = date.split('/').reverse();
    return `${dateArray[0]}-${dateArray[1]}-${dateArray[2]}`;
  }

  getItemsInStockWithoutPurchaseOrder(item: FormGroup) {
    if (!item.value.productVariation?.sku) return null;
    const { currentPosition } = item.value.productVariation;
    if (this.purchaseOrder.status === PurchaseOrderStatus.COMPLETED) {
      return currentPosition - item.value.amount;
    }
    return currentPosition;
  }

  getItemsInStockWithPurchaseOrder(item: FormGroup) {
    if (!item.value.productVariation?.sku) return null;
    const currentPosition = this.getItemsInStockWithoutPurchaseOrder(item);
    return currentPosition + item.value.amount;
  }
}
