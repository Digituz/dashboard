import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { SalesOrderDTO } from '../sales-order.dto';
import { SalesOrdersService } from '../sales-orders.service';
import { Router, ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-sales-order-form',
  templateUrl: './sales-order-form.component.html',
  styleUrls: ['./sales-order-form.component.scss'],
})
export class SalesOrderFormComponent implements OnInit {
  formFields: FormGroup;
  salesOrder: SalesOrderDTO;
  loading: boolean = true;

  constructor(
    private salesOrdersService: SalesOrdersService,
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
      customer: [salesOrderDTO.customer?.cpf || null],
      discount: [salesOrderDTO.discount|| 0],
      paymentType: [salesOrderDTO.paymentType|| null],
      paymentStatus: [salesOrderDTO.paymentStatus|| null],
      installments: [salesOrderDTO.installments|| 0],
      shippingType: [salesOrderDTO.shippingType|| null],
      shippingPrice: [salesOrderDTO.shippingPrice|| 0],
      customerName: [salesOrderDTO.customerName|| ''],
      shippingStreetAddress: [salesOrderDTO.shippingStreetAddress|| ''],
      shippingStreetNumber: [salesOrderDTO.shippingStreetNumber|| ''],
      shippingStreetNumber2: [salesOrderDTO.shippingStreetNumber2|| ''],
      shippingNeighborhood: [salesOrderDTO.shippingNeighborhood|| ''],
      shippingCity: [salesOrderDTO.shippingCity|| ''],
      shippingState: [salesOrderDTO.shippingState|| ''],
      shippingZipAddress: [salesOrderDTO.shippingZipAddress|| ''],
      creationDate: [salesOrderDTO.creationDate|| null],
      approvalDate: [salesOrderDTO.approvalDate|| null],
      cancellationDate: [salesOrderDTO.cancellationDate|| null],
      total: [salesOrderDTO.total|| 0],
    });
    this.loading = false;
  }

  submitSalesOrder() {}
}
