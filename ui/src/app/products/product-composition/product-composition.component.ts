import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ProductsService } from '../products.service';
import { ProductVariationDetailsDTO } from '@app/products/product-variation-details.dto';

@Component({
  selector: 'app-product-composition',
  templateUrl: './product-composition.component.html',
  styleUrls: ['./product-composition.component.scss'],
})
export class ProductCompositionComponent implements OnInit {
  formFields: FormGroup;
  formFieldsVariation: FormGroup;
  isModalVisible: boolean = false;
  showRemoveButton: boolean = false;
  productVariations: ProductVariationDetailsDTO[] = [];
  constructor(private fb: FormBuilder, private productService: ProductsService) {}

  ngOnInit(): void {}

  handleCancel(): void {
    this.isModalVisible = false;
  }

  openDialog() {
    this.formFieldsVariation = this.fb.group({
      product: '',
    });
    this.isModalVisible = true;
    this.showRemoveButton = false;
  }

  submitProductVariation() {
    const composition = this.formFieldsVariation.value;
    console.log(composition.product);
    this.isModalVisible = false;
  }

  search(event: any) {
    this.productService.findProductVariations(event.query).subscribe((results) => {
      this.productVariations = results;
    });
  }
}
