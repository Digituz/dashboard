import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { InventoryMovement } from '@app/inventory/inventory-movement.entity';
import { ProductsService } from '@app/products/products.service';
import Product from '@app/products/product.entity';

interface MovementType {
  label: string;
  value: string;
}

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
  movementTypes: MovementType[] = [
    { label: 'Entrada', value: 'INPUT' },
    { label: 'Saída', value: 'OUTPUT' },
  ];

  constructor(private fb: FormBuilder, private productsService: ProductsService) {}

  ngOnInit(): void {}

  private configureFormFields(inventoryMovement: InventoryMovement) {
    this.formFields = this.fb.group({
      product: [inventoryMovement?.product || null],
      description: [inventoryMovement?.description || ''],
      amount: [inventoryMovement ? Math.abs(inventoryMovement.amount) : ''],
      movementType: [inventoryMovement?.amount < 0 ? this.movementTypes[1] : this.movementTypes[0]],
    });
    this.loading = false;
  }

  openDialog() {
    this.isModalVisible = true;
    this.configureFormFields(null);
  }

  submitMovement() {
    const formValue = this.formFields.value;
    const input = formValue.movementType === 'INPUT';
    const movement: InventoryMovement = {
      product: formValue.product,
      description: formValue.description,
      amount: formValue.amount * (input ? 1 : -1),
    };
    console.log(movement);
  }

  handleCancel() {}

  removeMovement() {}

  search(event: any) {
    this.productsService.findProducts(event.query).subscribe((results) => {
      this.products = results.items;
    });
  }
}
