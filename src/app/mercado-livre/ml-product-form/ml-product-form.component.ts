import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import Product from '@app/products/product.entity';
import adProduct from '../mercado-livre.entity';
import { MercadoLivreService } from '../mercado-livre.service';
import MLCategory from '../ml-category.entity';

@Component({
  selector: 'app-ml-product-form',
  templateUrl: './ml-product-form.component.html',
  styleUrls: ['./ml-product-form.component.scss'],
})
export class MLProductFormComponent implements OnInit {
  loading: boolean = true;
  adProduct: adProduct;
  formFields: FormGroup;
  product: Product;
  productDetails: string;
  categories: MLCategory[] = [];
  adTypes = [
    {
      label: 'Premium',
      value: 'gold_pro',
    },
    {
      label: 'Diamante',
      value: 'gold_premium',
    },
    {
      label: 'Clássico',
      value: 'gold_special',
    },
    {
      label: 'Ouro',
      value: 'gold',
    },
    {
      label: 'Prata',
      value: 'silver',
    },
    {
      label: 'Bronze',
      value: 'bronze',
    },
    {
      label: 'Grátis',
      value: 'free',
    },
  ];
  value: string;

  constructor(
    private fb: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
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
    product.adProduct = product.adProduct.filter((adProduct) => adProduct.isActive === true);
    const category = {
      category_id: product.adProduct[0]?.categoryId,
      category_name: product.adProduct[0]?.categoryName,
    };
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
      category: [category || null, Validators.required],
      adType: [product.adProduct[0]?.adType || null, Validators.required],
    });
    this.loading = false;
  }

  submitMLProduct() {
    const formValue = this.formFields.value;
    if (!formValue.category.category_name) {
      this.formFields.get('category').setValue(null);
    }
    if (!this.formFields.valid) {
      this.markAllFieldsAsTouched(this.formFields);
    } else {
      const id = formValue.category.category_id;
      const name = formValue.category.category_name;
      const adType = formValue.adType;
      const adProduct = {
        id: this.product.adProduct ? this.product.adProduct[0]?.id : null,
        product: { id: this.product.id },
        categoryId: id,
        categoryName: name,
        adType,
        isSynchronized: this.product.adProduct[0]?.isSynchronized,
      };
      this.mercadoLivreService.save(adProduct).subscribe();
      this.router.navigate(['/mercado-livre/list']);
    }
  }

  search(event: any) {
    this.mercadoLivreService.findCategories(event.query).subscribe((categories: any) => {
      this.categories = categories;
    });
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
}
