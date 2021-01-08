import { Component, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ProductsService } from '../products.service';
import { Router, ActivatedRoute } from '@angular/router';
import Product from '../product.entity';
import { ProductVariation } from '../product-variation.entity';
import { Image } from '../../media-library/image.entity';
import { ProductImage } from '../product-image.entity';
import { ProductCategory } from '../product-category.enum';
import { ProductComposition } from '../product-composition.entity';
import { ProductCompositionComponent } from '../product-composition/product-composition.component';
import { CustomSkuValidator } from '../sku.validator';
import { MessagesService } from '@app/messages/messages.service';
interface Category {
  label: string;
  value: ProductCategory;
}

@Component({
  selector: 'app-product-form',
  templateUrl: './product-form.component.html',
  styleUrls: ['./product-form.component.scss'],
})
export class ProductFormComponent implements OnInit {
  @ViewChild('productCompositionComponent') productCompositionComponent: ProductCompositionComponent;

  formFields: FormGroup;
  formFieldsVariation: FormGroup;
  editProductVariationSku: string;
  productDetails: string;
  product: Product;
  variations: ProductVariation[];
  images: ProductImage[];
  loading: boolean = true;
  isModalVisible: boolean = false;
  showRemoveButton: boolean = false;
  variationBeingEdited: ProductVariation;
  categories: Category[] = [
    { label: 'Acessórios', value: ProductCategory.ACESSORIOS },
    { label: 'Anéis', value: ProductCategory.ANEIS },
    { label: 'Berloques', value: ProductCategory.BERLOQUES },
    { label: 'Brincos', value: ProductCategory.BRINCOS },
    { label: 'Camisetas', value: ProductCategory.CAMISETAS },
    { label: 'Colares', value: ProductCategory.COLARES },
    { label: 'Conjuntos', value: ProductCategory.CONJUNTOS },
    { label: 'Decoração', value: ProductCategory.DECORACAO },
    { label: 'Pulseiras', value: ProductCategory.PULSEIRAS },
  ];

  constructor(
    private fb: FormBuilder,
    private productService: ProductsService,
    private router: Router,
    private route: ActivatedRoute,
    private customSkuValidator: CustomSkuValidator,
    private messagesService: MessagesService
  ) {}

  ngOnInit(): void {
    const sku = this.route.snapshot.params.sku;
    if (sku === 'new') {
      this.product = this.productService.getCopiedProduct() || {};
      this.variations = [
        {
          parentSku: null,
          sku: null,
          sellingPrice: 0,
          description: 'Tamanho Único',
        },
      ];
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
      sku: [
        { value: product.sku || '', disabled: !!product.id },
        Validators.required,
        this.customSkuValidator.existingSku(false),
      ],
      ncm: [product.ncm || '', [Validators.required, Validators.maxLength(10)]],
      title: [product.title || '', [Validators.required, Validators.minLength(5)]],
      description: [product.description || '', Validators.required],
      sellingPrice: [{ value: product.sellingPrice || null, disabled: true }],
      height: [product.height || null],
      width: [product.width || null],
      length: [product.length || null],
      weight: [product.weight || null],
      isActive: [product.isActive || false, Validators.required],
      category: [product.category || false],
    });
    this.productDetails = product.productDetails || '';
    this.loading = false;
  }

  submitProductDetails() {
    if (!this.formFields.valid) {
      this.markAllFieldsAsTouched(this.formFields);
    } else {
      const invalidVariation = this.variations.find((variation) => !variation.sku);
      if (this.variations.length === 0) {
        return this.messagesService.showError('O produto deve ter ao menos uma variação.');
      }
      if (invalidVariation) {
        return this.messagesService.showError('Uma variação não tem SKU definido.');
      }
      const product = this.formFields.value;
      product.productDetails = this.productDetails.replace(
        /([\uE000-\uF8FF]|\uD83C[\uDC00-\uDFFF]|\uD83D[\uDC00-\uDFFF]|[\u2011-\u26FF]|\uD83E[\uDD10-\uDDFF])/g,
        ''
      );
      product.productDetails;
      product.productVariations = this.variations;
      product.productImages = this.images;
      product.productComposition = this.product.productComposition?.map((item) => item.productVariation.sku);
      if (this.product.id) {
        // field is disabled, so the form doesn't provide it
        product.sku = this.product.sku;
      }

      this.productService.saveProduct(product).subscribe(() => {
        this.router.navigate(['/products']);
      });
    }
  }

  handleCancel(): void {
    this.isModalVisible = false;
  }

  newProductVariation(): void {
    this.formFieldsVariation = this.fb.group({
      skuVariation: ['', Validators.required, this.customSkuValidator.existingSku(true)],
      descriptionVariation: ['', Validators.required],
      sellingPriceVariation: ['', Validators.required],
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
    this.editProductVariationSku = productVariation.sku;
    this.formFieldsVariation = this.fb.group({
      skuVariation: [
        { value: productVariation.sku, disabled: !!productVariation.sku },
        Validators.required,
        this.customSkuValidator.existingSku(true),
      ],
      descriptionVariation: [productVariation.description, Validators.required],
      sellingPriceVariation: [productVariation.sellingPrice, Validators.required],
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
    if (!this.formFieldsVariation.valid) {
      this.markAllFieldsAsTouched(this.formFieldsVariation);
    } else {
      const variationFields = this.formFieldsVariation.value;
      const productVariation = {
        sku: variationFields.skuVariation,
        description: variationFields.descriptionVariation,
        sellingPrice: variationFields.sellingPriceVariation,
      };
      if (this.variationBeingEdited) {
        if (this.editProductVariationSku) {
          productVariation.sku = this.editProductVariationSku;
        }
        Object.assign(this.variationBeingEdited, productVariation);
        this.variations = [...this.variations];
      } else {
        const variation: ProductVariation = {
          parentSku: this.product.sku,
          ...productVariation,
        };
        this.variations = [...this.variations, variation];
      }
      this.isModalVisible = false;
    }
  }

  removeItemFromComposition(removedItem: ProductComposition) {
    this.product.productComposition = this.product.productComposition.filter(
      (item) => item.productVariation.sku !== removedItem.productVariation.sku
    );
  }

  newItemOnComposition() {
    this.productCompositionComponent.openDialog();
  }

  onItemChosen(event: any) {
    const productVariation = event;
    if (this.product.productComposition === undefined) {
      this.product.productComposition = [];
    }
    this.product.productComposition.push({
      productVariation: {
        ...productVariation,
        product: {
          title: productVariation.title,
        },
      },
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

  isFieldVariationInvalid(field: string) {
    return !this.formFieldsVariation.get(field).valid && this.formFieldsVariation.get(field).touched;
  }
}
