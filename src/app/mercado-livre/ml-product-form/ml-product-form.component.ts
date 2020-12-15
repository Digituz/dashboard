import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import Product from '@app/products/product.entity';
import MLProduct from '../mercado-livre.entity';
import { MercadoLivreService } from '../mercado-livre.service';

interface MLCategorie {
  id: string;
  name: string;
}

@Component({
  selector: 'app-ml-product-form',
  templateUrl: './ml-product-form.component.html',
  styleUrls: ['./ml-product-form.component.scss'],
})
export class MLProductFormComponent implements OnInit {
  loading: boolean = true;
  MLProduct: MLProduct;
  formFields: FormGroup;
  product: Product;
  productDetails: string;
  categories: MLCategorie[] = [];

  constructor(
    private fb: FormBuilder,
    private route: ActivatedRoute,
    private mercadoLivreService: MercadoLivreService
  ) {}

  ngOnInit(): void {
    const sku = this.route.snapshot.params.sku;
    this.mercadoLivreService.loadProduct(sku).subscribe((product) => {
      this.product = product;
      this.configureFormFields(product);
    });
  }

  private configureFormFields(product: Product) {
    this.formFields = this.fb.group({
      sku: [{ value: product.sku, disabled: true }],
      ncm: [{ value: product.ncm, disabled: true }],
      title: [{ value: product.title, disabled: true }],
      description: [{ value: product.description, disabled: true }],
      sellingPrice: [{ value: product.sellingPrice, disabled: true }],
      height: [{ value: product.height, disabled: true }],
      width: [{ value: product.width, disabled: true }],
      length: [{ value: product.length, disabled: true }],
      weight: [{ value: product.weight, disabled: true }],
      category: [product.MLProduct?.categoryName || ''],
    });
    this.loading = false;
  }

  submitMLProduct() {
    const formValue = this.formFields.value;
    const id = formValue.category.category_id;
    const name = formValue.category.category_name;
    const mlCategory: MLCategorie = {
      id,
      name,
    };

    const mlProduct = {
      sku: this.product.sku,
      mlCategory,
    };
    this.mercadoLivreService.save(mlProduct);
  }

  search(event: any) {
    this.mercadoLivreService.findCategories(event.query).subscribe((categories: any) => {
      this.categories = categories;
    });
  }
}
