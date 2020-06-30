import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ProductsService } from '../products.service';
import { Router, ActivatedRoute } from '@angular/router';
import Product from '../product.entity';
import { ProductVariation } from '../product-variation.entity';
import { Image } from '../../media-library/image.entity';
import { ProductImage } from '../product-image.entity';

@Component({
  selector: 'app-product-form',
  templateUrl: './product-form.component.html',
  styleUrls: ['./product-form.component.scss'],
})
export class ProductFormComponent implements OnInit {
  formFields: FormGroup;
  formFieldsVariation: FormGroup;
  productDetails: string;
  product: Product;
  variations: ProductVariation[];
  images: ProductImage[];
  loading: boolean = true;
  isModalVisible: boolean = false;
  showRemoveButton: boolean = false;
  variationBeingEdited: ProductVariation;

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
      this.variations = [];
      this.images = [];
      this.configureFormFields(this.product);
    } else {
      this.productService.loadProduct(sku).subscribe((product) => {
        product.productVariations = product.productVariations.map((v) => ({ ...v, parentSku: product.sku }));
        this.variations = product.productVariations;
        this.images = product.productImages;
        this.product = product;
        this.configureFormFields(product);
      });
    }
  }

  private configureFormFields(product: Product) {
    this.formFields = this.fb.group({
      sku: [product.sku || ''],
      ncm: [product.ncm || ''],
      title: [product.title || ''],
      description: [product.description || ''],
      sellingPrice: [product.sellingPrice || null],
      height: [product.height || null],
      width: [product.width || null],
      length: [product.length || null],
      weight: [product.weight || null],
      isActive: [product.isActive || false],
    });
    this.productDetails = product.productDetails || '';
    this.loading = false;
  }

  submitProductDetails() {
    const product = this.formFields.value;
    product.productDetails = this.productDetails;
    product.productVariations = this.variations;
    product.productImages = this.images;

    this.productService.saveProduct(product).subscribe(() => {
      // this.router.navigate(['/products']);
    });
  }

  handleCancel(): void {
    this.isModalVisible = false;
  }

  newProductVariation(): void {
    this.formFieldsVariation = this.fb.group({
      sku: '',
      description: '',
      sellingPrice: '',
    });
    this.isModalVisible = true;
    this.showRemoveButton = false;
    this.variationBeingEdited = null;
  }

  imagesSelected(images: Image[]): void {
    this.images = images.map((image, idx) => ({
      order: idx,
      image,
    }));
  }

  editProductVariation(productVariation: ProductVariation): void {
    this.formFieldsVariation = this.fb.group({
      sku: productVariation.sku,
      description: productVariation.description,
      sellingPrice: productVariation.sellingPrice,
    });
    this.isModalVisible = true;
    this.showRemoveButton = true;
    this.variationBeingEdited = productVariation;
  }

  removeVariation() {
    if (!this.variationBeingEdited) return;
    this.variations = this.variations.filter((v) => v.sku != this.variationBeingEdited.sku);
    this.isModalVisible = false;
  }

  submitVariation(): void {
    const inputValues = this.formFieldsVariation.value;
    if (this.variationBeingEdited) {
      Object.assign(this.variationBeingEdited, inputValues);
      this.variations = [...this.variations];
    } else {
      const variation: ProductVariation = {
        parentSku: this.product.sku,
        ...inputValues,
      };
      this.variations = [...this.variations, variation];
    }
    this.isModalVisible = false;
  }
}
