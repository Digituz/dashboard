import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { InventoryMovement } from '@app/inventory/inventory-movement.entity';
import { ProductsService } from '@app/products/products.service';
import Product from '@app/products/product.entity';

@Component({
  selector: 'app-move-inventory-dialog',
  templateUrl: './move-inventory-dialog.component.html',
  styleUrls: ['./move-inventory-dialog.component.scss'],
})
export class MoveInventoryDialogComponent implements OnInit {
  formFields: FormGroup;
  loading: boolean = false;
  isModalVisible: boolean = false;
  showRemoveButton: boolean = false;
  products: Product[] = [];

  constructor(private fb: FormBuilder, private productsService: ProductsService) {}

  ngOnInit(): void {}

  private configureFormFields(inventoryMovement: InventoryMovement) {
    this.formFields = this.fb.group({
      sku: [inventoryMovement?.inventory.product.sku || ''],
      description: [inventoryMovement?.description || ''],
      amount: [inventoryMovement?.amount || ''],
    });
    this.loading = false;
  }

  openDialog() {
    this.isModalVisible = true;
    this.configureFormFields(null);
  }

  submitMovement() {}

  handleCancel() {}

  removeMovement() {}

  search(event: any) {
    this.productsService.findProducts(event.query).subscribe((results) => {
      this.products = results.items;
    });
  }
}
