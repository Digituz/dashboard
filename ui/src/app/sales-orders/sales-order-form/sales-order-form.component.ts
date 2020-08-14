import * as cep from 'cep-promise';
import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, FormArray, Validators } from '@angular/forms';
import { SalesOrderDTO } from '../sales-order.dto';
import { SalesOrdersService } from '../sales-orders.service';
import { Router, ActivatedRoute } from '@angular/router';
import { ComboBoxOption } from '@app/util/combo-box-option.interface';
import { PaymentStatus } from '../payment-status.enum';
import { PaymentType } from '../payment-type.enum';
import { Customer } from '@app/customers/customer.entity';
import { CustomersService } from '@app/customers/customers.service';
import { ProductsService } from '@app/products/products.service';
import { ProductVariationDetailsDTO } from '@app/products/product-variation-details.dto';
import { ShippingType } from '../shipping-type.enum';
import { customerValidator, productItemValidator } from './sales-order-form.validators';
import { SaleOrderItemDTO } from '../sale-order-item.dto';

@Component({
  selector: 'app-sales-order-form',
  templateUrl: './sales-order-form.component.html',
  styleUrls: ['./sales-order-form.component.scss'],
})
export class SalesOrderFormComponent implements OnInit {
  formFields: FormGroup;
  formSubmitted: boolean = false;
  salesOrder: SalesOrderDTO;
  salesOrderId?: number;
  loading: boolean = true;
  productVariations: ProductVariationDetailsDTO[] = [];
  total: number;

  paymentTypes: ComboBoxOption[] = [
    { label: 'Boleto', value: PaymentType.BANK_SLIP },
    { label: 'Cartão de Crédito', value: PaymentType.CREDIT_CARD },
  ];

  paymentStatus: ComboBoxOption[] = [
    { label: 'Em Processamento', value: PaymentStatus.IN_PROCESS },
    { label: 'Aprovada', value: PaymentStatus.APPROVED },
    { label: 'Cancelada', value: PaymentStatus.CANCELLED },
    { label: 'Estornada', value: PaymentStatus.REFUNDED },
    { label: 'Rejeitada', value: PaymentStatus.REJECTED },
  ];

  installments: ComboBoxOption[] = [
    { label: '1x', value: 1 },
    { label: '2x', value: 2 },
    { label: '3x', value: 3 },
    { label: '4x', value: 4 },
    { label: '5x', value: 5 },
    { label: '6x', value: 6 },
    { label: '7x', value: 7 },
    { label: '8x', value: 8 },
    { label: '9x', value: 9 },
    { label: '10x', value: 10 },
    { label: '11x', value: 11 },
    { label: '12x', value: 12 },
  ];

  shippingTypes: ComboBoxOption[] = [
    { label: `Correios - ${ShippingType.PAC}`, value: 'PAC' },
    { label: `Correios - ${ShippingType.SEDEX}`, value: 'SEDEX' },
    { label: 'Motoboy', value: ShippingType.SAME_DAY },
  ];

  customers: Customer[] = [];

  constructor(
    private customersService: CustomersService,
    private salesOrdersService: SalesOrdersService,
    private productsService: ProductsService,
    private fb: FormBuilder,
    private router: Router,
    private route: ActivatedRoute
  ) {}

  ngOnInit(): void {
    const referenceCode = this.route.snapshot.params.referenceCode;

    if (referenceCode === 'new') {
      this.salesOrder = {};
      this.configureFormFields(this.salesOrder);
    } else {
      this.salesOrdersService.loadSalesOrder(referenceCode).subscribe((salesOrder) => {
        this.salesOrder = salesOrder;
        this.salesOrderId = salesOrder.id;
        this.configureFormFields(salesOrder);
      });
    }
  }

  private createItemsForSalesOrder(salesOrderDTO: SalesOrderDTO): FormArray {
    return this.fb.array(
      salesOrderDTO.items.map((item) => this.createItem(item)),
      [Validators.required, Validators.minLength(1)]
    );
  }

  private configureFormFields(salesOrderDTO: SalesOrderDTO) {
    const itemsField = salesOrderDTO.items
      ? this.createItemsForSalesOrder(salesOrderDTO)
      : this.fb.array([this.createItem()], [Validators.required, Validators.minLength(1)]);

    this.formFields = this.fb.group({
      referenceCode: [
        salesOrderDTO.referenceCode || '',
        [Validators.required, Validators.minLength(1), Validators.maxLength(36)],
      ],
      customer: [salesOrderDTO.customer || null, [Validators.required, customerValidator]],
      discount: [salesOrderDTO.discount || 0],
      paymentType: [salesOrderDTO.paymentType || null, [Validators.required]],
      paymentStatus: [salesOrderDTO.paymentStatus || null, [Validators.required]],
      installments: [salesOrderDTO.installments || '1', [Validators.required]],
      shippingType: [salesOrderDTO.shippingType || null, [Validators.required]],
      shippingPrice: [salesOrderDTO.shippingPrice || 0, [Validators.required]],
      customerName: [salesOrderDTO.customerName || '', [Validators.required]],
      shippingStreetAddress: [salesOrderDTO.shippingStreetAddress || '', [Validators.required]],
      shippingStreetNumber: [salesOrderDTO.shippingStreetNumber || '', [Validators.required]],
      shippingStreetNumber2: [salesOrderDTO.shippingStreetNumber2 || ''],
      shippingNeighborhood: [salesOrderDTO.shippingNeighborhood || '', [Validators.required]],
      shippingCity: [salesOrderDTO.shippingCity || '', [Validators.required]],
      shippingState: [salesOrderDTO.shippingState || '', [Validators.required]],
      shippingZipAddress: [salesOrderDTO.shippingZipAddress || '', [Validators.required]],
      creationDate: [salesOrderDTO.creationDate || null],
      approvalDate: [salesOrderDTO.approvalDate || null],
      cancellationDate: [salesOrderDTO.cancellationDate || null],
      total: [salesOrderDTO.total || 0],
      items: itemsField,
    });
    this.loading = false;
  }

  async loadAddress() {
    const zipAddress = this.formFields.get('shippingZipAddress').value;
    const address = await cep(zipAddress.replace(/\D/g, ''));
    this.formFields.patchValue({
      shippingStreetAddress: address.street,
      shippingCity: address.city,
      shippingNeighborhood: address.neighborhood,
      shippingState: address.state,
    });
  }

  addItem(): void {
    const items = this.formFields.get('items') as FormArray;
    items.push(this.createItem());
  }

  removeItem(index: number) {
    const items = this.formFields.get('items') as FormArray;
    items.removeAt(index);
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
      const itemValue = formGroup.get('price').value;
      const itemDiscount = formGroup.get('discount').value;
      const itemAmount = formGroup.get('amount').value;
      itemsTotal += (itemValue - itemDiscount) * itemAmount;
    }

    const saleOrderDiscount = this.formFields.get('discount').value || 0;
    itemsTotal -= saleOrderDiscount;

    const shippingPrice = this.formFields.get('shippingPrice').value || 0;
    itemsTotal += shippingPrice;

    this.formFields.patchValue({
      total: itemsTotal,
    });
  }

  createItem(salesOrderItem?: SaleOrderItemDTO): FormGroup {
    return this.fb.group({
      productVariation: [salesOrderItem || null, [Validators.required, productItemValidator]],
      price: [salesOrderItem ? salesOrderItem.price : 0, [Validators.required]],
      discount: [salesOrderItem ? salesOrderItem.discount : 0, [Validators.required]],
      amount: [salesOrderItem ? salesOrderItem.amount : 1, [Validators.required]],
    });
  }

  get items(): FormArray {
    return this.formFields.get('items') as FormArray;
  }

  submitSalesOrder() {
    this.formSubmitted = true;

    if (!this.formFields.valid) {
      return;
    }

    const salesOrder: SalesOrderDTO = this.formFields.value;
    salesOrder.items = salesOrder.items.map((item: any) => ({
      sku: item.productVariation.sku,
      discount: item.discount,
      amount: item.amount,
      price: item.price,
    }));

    if (this.salesOrderId) {
      salesOrder.id = this.salesOrderId;
    }

    this.salesOrdersService.save(salesOrder).subscribe(() => {
      this.router.navigate(['/sales-orders']);
    });
  }

  search(event: any) {
    this.customersService.findCustomers(event.query).subscribe((results) => {
      this.customers = results.items;
    });
  }

  searchProductVariations(event: any) {
    this.productsService.findProductVariations(event.query).subscribe((results) => {
      this.productVariations = results;
    });
  }
}
