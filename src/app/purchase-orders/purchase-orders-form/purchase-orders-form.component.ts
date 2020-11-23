import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, FormArray, Validators } from '@angular/forms';
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
  supplierSugestion: Supplier[] = [];
  purchaseOrderItems = new FormArray([]);
  loading: boolean = true;
  id: any;

  purchaseOrderStatus: ComboBoxOption[] = [
    { label: 'Em Processamento', value: PurchaseOrderStatus.IN_PROCESS },
    { label: 'Completo', value: PurchaseOrderStatus.COMPLETED },
    { label: 'Cancelada', value: PurchaseOrderStatus.CANCELLED },
  ];

  constructor(
    private fb: FormBuilder,
    private router: Router,
    private route: ActivatedRoute,
    private productService: ProductsService,
    private supplierService: SupplierService,
    private purcahseOrderService: PurchaseOrdersService
  ) {}

  ngOnInit(): void {
    this.id = this.route.snapshot.params.referenceCode;

    if (this.id === 'new') {
      this.id = null;
      this.purchaseOrder = {};
      this.configureFormFields(this.purchaseOrder);
    } else {
      this.purcahseOrderService.loadPurchaseOrder(this.id).subscribe((results) => {
        const purchaseOrder: PurchaseOrder = {
          id: this.id,
          creationDate: format(new Date(results.creationDate), 'dd/MM/yyyy'),
          completionDate: format(new Date(results.completionDate), 'dd/MM/yyyy'),
          discount: results.discount,
          referenceCode: results.referenceCode,
          total: results.total,
          shippingPrice: results.shippingPrice,
          supplier: results.supplier,
          items: results.items,
          status: results.status,
        };
        this.configureFormFields(purchaseOrder);
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
      creationDate: [purchaseOrder.creationDate || format(new Date(), 'dd/MM/yyyy'), [Validators.required]],
      completionDate: [purchaseOrder.completionDate || ''],
      total: [purchaseOrder.total || 0.0, [Validators.required]],
      discount: [purchaseOrder.discount || 0.0],
      shippingPrice: [purchaseOrder.shippingPrice || 0.0, [Validators.required]],
      items: itemsField,
      status: [purchaseOrder.status || null, [Validators.required]],
    });
    this.loading = false;
  }

  addItem() {
    const items = this.formFields.controls.items as FormArray;
    items.push(this.createItem());
  }

  removeItem(index: number) {
    const items = this.formFields.controls.items as FormArray;
    items.removeAt(index);
  }

  createItem(purchaseOrderItem?: PurchaseOrderItem): FormGroup {
    if (!purchaseOrderItem) {
      purchaseOrderItem = {};
    }
    return this.fb.group({
      productVariation: [purchaseOrderItem || null, [Validators.required]],
      price: [
        purchaseOrderItem.productVariation ? purchaseOrderItem.productVariation.sellingPrice : 0,
        [Validators.required],
      ],
      amount: [purchaseOrderItem.productVariation ? purchaseOrderItem.amount : 0, [Validators.required]],
    });
  }

  private createItemsPurchaseOrder(purchaseOrder: PurchaseOrder): FormArray {
    return this.fb.array(
      purchaseOrder.items.map((item) => this.createItem(item)),
      [Validators.required, Validators.minLength(1)]
    );
  }

  get items(): FormArray {
    return this.formFields.get('items') as FormArray;
  }

  submit() {
    if (!this.formFields.valid) {
      this.markAllFieldsAsTouched(this.formFields);
    } else {
      const values = this.formFields.value;
      const supplier = values.supplier;
      const referenceCode = values.referenceCode;
      const creationDate = this.formatDate(values.creationDate);
      const completionDate = this.formatDate(values.completionDate);
      const total = values.total;
      const discount = values.discount;
      const status = values.status;
      const shippingPrice = values.shippingPrice;
      const items = values.items.map((item: any) => {
        if (item.productVariation.productVariation) {
          item.productVariation = { ...item.productVariation, id: item.productVariation.productVariation.id };
        }
        return {
          amount: item.amount,
          price: item.price,
          productVariation: item.productVariation.id,
        };
      });
      let purchaseOrder: PurchaseOrder = {
        supplier,
        referenceCode,
        creationDate,
        completionDate,
        total,
        discount,
        shippingPrice,
        items,
        status,
      };
      if (this.id !== 'new') {
        purchaseOrder = { ...purchaseOrder, id: Number.parseInt(this.id) };
      }
      this.purcahseOrderService.save(purchaseOrder).subscribe(() => {
        this.router.navigate(['/purchase-orders']);
      });
    }
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

  selectProductVariation(value: ProductVariationDetailsDTO, index: number) {
    const items = this.formFields.get('items') as FormArray;
    const formGroup = items.at(index) as FormGroup;
    formGroup.patchValue({ price: value.sellingPrice });
    formGroup.patchValue({ discount: 0 });
    formGroup.patchValue({ amount: 1 });
    this.updatePrice();
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

  formatDate(date: string) {
    if (!date) {
      return null;
    }
    const dateArray = date.split('/').reverse();
    return `${dateArray[0]}-${dateArray[1]}-${dateArray[2]}`;
  }
}
