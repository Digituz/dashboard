import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ProductsService } from '../products.service';
import { Router, ActivatedRoute } from '@angular/router';
import Product from '../product.entity';

@Component({
  selector: 'app-product-form',
  templateUrl: './product-form.component.html',
  styleUrls: ['./product-form.component.scss'],
})
export class ProductFormComponent implements OnInit {
  formFields: FormGroup;
  productDetails: string;
  product: Product;
  loading: boolean = true;

  constructor(
    private fb: FormBuilder,
    private productService: ProductsService,
    private router: Router,
    private route: ActivatedRoute
  ) {}

  ngOnInit(): void {
    const sku = this.route.snapshot.params.sku;

    if (sku === 'new') {
      this.product = {};
      this.configureFormFields(this.product);
    } else {
      this.productService.loadProduct(sku).subscribe((product) => {
        this.configureFormFields(product);
      });
    }
  }

  private configureFormFields(product: Product) {
    this.formFields = this.fb.group({
      sku: [product.sku || ''],
      title: [product.title || ''],
      description: [product.description || ''],
      sellingPrice: [product.sellingPrice || null],
      isActive: [product.isActive || false],
    });
    this.productDetails = product.productDetails;
    this.loading = false;
  }

  submitProductDetails() {
    const product = this.formFields.value;
    product.productDetails = this.productDetails;
    this.productService.saveProduct(product).subscribe(() => {
      this.router.navigate(['/products']);
    });
  }
}
