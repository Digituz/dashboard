import * as cep from 'cep-promise';
import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, FormArray } from '@angular/forms';
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

@Component({
  selector: 'app-sales-order-form',
  templateUrl: './sales-order-form.component.html',
  styleUrls: ['./sales-order-form.component.scss'],
})
export class SalesOrderFormComponent implements OnInit {
  formFields: FormGroup;
  salesOrder: SalesOrderDTO;
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
    { label: '1x', value: '1' },
    { label: '2x', value: '2' },
    { label: '3x', value: '3' },
    { label: '4x', value: '4' },
    { label: '5x', value: '5' },
    { label: '6x', value: '6' },
    { label: '7x', value: '7' },
    { label: '8x', value: '8' },
    { label: '9x', value: '9' },
    { label: '10x', value: '10' },
    { label: '11x', value: '11' },
    { label: '12x', value: '12' },
  ];

  shippingTypes: ComboBoxOption[] = [
    { label: 'PAC', value: `Correios - ${ShippingType.PAC}` },
    { label: 'SEDEX', value: `Correios - ${ShippingType.SEDEX}` },
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
        this.configureFormFields(salesOrder);
      });
    }
  }

  private configureFormFields(salesOrderDTO: SalesOrderDTO) {
    this.formFields = this.fb.group({
      referenceCode: [salesOrderDTO.referenceCode || ''],
      customer: [salesOrderDTO.customer || null],
      discount: [salesOrderDTO.discount || 0],
      paymentType: [salesOrderDTO.paymentType || null],
      paymentStatus: [salesOrderDTO.paymentStatus || null],
      installments: [salesOrderDTO.installments || '1'],
      shippingType: [salesOrderDTO.shippingType || null],
      shippingPrice: [salesOrderDTO.shippingPrice || 0],
      customerName: [salesOrderDTO.customerName || ''],
      shippingStreetAddress: [salesOrderDTO.shippingStreetAddress || ''],
      shippingStreetNumber: [salesOrderDTO.shippingStreetNumber || ''],
      shippingStreetNumber2: [salesOrderDTO.shippingStreetNumber2 || ''],
      shippingNeighborhood: [salesOrderDTO.shippingNeighborhood || ''],
      shippingCity: [salesOrderDTO.shippingCity || ''],
      shippingState: [salesOrderDTO.shippingState || ''],
      shippingZipAddress: [salesOrderDTO.shippingZipAddress || ''],
      creationDate: [salesOrderDTO.creationDate || null],
      approvalDate: [salesOrderDTO.approvalDate || null],
      cancellationDate: [salesOrderDTO.cancellationDate || null],
      total: [salesOrderDTO.total || 0],
      items: this.fb.array([this.createItem()]),
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
    itemsTotal -= shippingPrice;

    this.salesOrder.total = itemsTotal;
  }

  createItem(): FormGroup {
    return this.fb.group({
      productVariation: null,
      price: 0,
      discount: 0,
      amount: 1,
    });
  }

  get items(): FormArray {
    return this.formFields.get('items') as FormArray;
  }

  submitSalesOrder() {}

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
