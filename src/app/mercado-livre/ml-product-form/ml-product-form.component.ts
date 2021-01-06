import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import Product from '@app/products/product.entity';
import MLProduct from '../mercado-livre.entity';
import { MercadoLivreService } from '../mercado-livre.service';

interface MLCategory {
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
      category: [category || null],
      adType: [product.adProduct[0]?.adType || null],
    });
    this.loading = false;
  }

  submitMLProduct() {
    const formValue = this.formFields.value;
    const id = formValue.category.category_id;
    const name = formValue.category.category_name;
    const adType = formValue.adType;

    const mlProduct = {
      id: this.product.adProduct ? this.product.adProduct[0]?.id : null,
      product: { id: this.product.id },
      categoryId: id,
      categoryName: name,
      adType,
      isSynchronized: this.product.adProduct[0]?.isSynchronized,
    };
    console.log(mlProduct);
    this.mercadoLivreService.save(mlProduct).subscribe();
    this.router.navigate(['/mercado-livre/list']);
  }

  search(event: any) {
    this.mercadoLivreService.findCategories(event.query).subscribe((categories: any) => {
      this.categories = categories;
    });
  }
}
