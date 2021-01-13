import { Component, OnInit, ViewChild } from '@angular/core';
import { DgzTableComponent } from '@app/@shared/dgz-table/dgz-table.component';
import Product from '@app/products/product.entity';
import { Pagination, QueryParam } from '@app/util/pagination';
import { Observable } from 'rxjs';
import { MenuItem } from 'primeng/api';
import { MercadoLivreService } from '../mercado-livre.service';
import MLCategory from '../ml-category.entity';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

interface statusOption {
  label: string;
  value: any;
}
@Component({
  selector: 'app-ml-product-list',
  templateUrl: './ml-product-list.component.html',
  styleUrls: ['./ml-product-list.component.scss'],
})
export class MLProductListComponent implements OnInit {
  @ViewChild('MLProductsTable') resultsTable: DgzTableComponent<any>;
  formFields: FormGroup;
  queryParams: QueryParam[] = [];
  query: string;
  categories: MLCategory[] = [];
  isModalVisible: boolean = false;
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
  statusOptions: statusOption[] = [
    { label: 'Todos', value: null },
    { label: 'Sincronizado', value: true },
    { label: 'Falha', value: false },
    { label: 'Pendente', value: 'notSync' },
  ];
  items: MenuItem[];
  activeItem: MenuItem;

  status: statusOption;

  constructor(private mercadoLivreService: MercadoLivreService, private fb: FormBuilder) {}

  ngOnInit(): void {
    this.items = [
      { label: 'Lista', icon: 'pi pi-fw pi-list', routerLink: '/mercado-livre/list' },
      { label: 'Erros', icon: 'pi pi-fw pi-exclamation-triangle', routerLink: '/mercado-livre/error-list' },
    ];
    this.activeItem = this.items[0];
  }

  loadData(
    pageNumber: number,
    pageSize: number,
    sortedBy?: string,
    sortDirectionAscending?: boolean,
    queryParams?: QueryParam[]
  ): Observable<Pagination<Product>> {
    return this.mercadoLivreService.loadData(pageNumber, pageSize, sortedBy, sortDirectionAscending, queryParams);
  }

  queryProducts() {
    this.queryParams = [
      { key: 'query', value: this.query },
      { key: 'status', value: this.status?.value },
    ];
    this.resultsTable.reload(this.queryParams);
  }

  openDialog() {
    this.isModalVisible = true;
    this.configureFormFields();
  }

  private configureFormFields() {
    this.formFields = this.fb.group({
      category: [null, Validators.required],
      adType: [null, Validators.required],
      additionalPrice: [null],
    });
  }

  updateQueryParams(queryParams: QueryParam[]) {
    this.query = queryParams?.find((q) => q.key === 'query')?.value.toString();
  }

  resetFilter() {
    this.query = '';
    return localStorage.removeItem('mercado-livre-list');
  }

  search(event: any) {
    this.mercadoLivreService.findCategories(event.query).subscribe((categories: any) => {
      this.categories = categories;
    });
  }

  createAd() {
    console.log(this.formFields.value);
    if (!this.formFields.valid) {
      this.markAllFieldsAsTouched(this.formFields);
    } else {
      const formValues = this.formFields.value;
      const categoryForm = formValues.category;
      const adType = formValues.adType;
      const additionalPrice = formValues.additionalPrice;

      console.log(categoryForm, adType, additionalPrice);
      const products = this.resultsTable.currentData;
      const category: MLCategory = { id: categoryForm.category_id, name: categoryForm.category_name };
      const filterProducts = products
        .filter((product) => product.isChecked === true)
        .map((product) => {
          return { id: product.id, mlId: product.adProduct.mlId };
        });
      this.mercadoLivreService.saveAll(filterProducts, category, additionalPrice).subscribe((result) => {
        this.resultsTable.reload(this.queryParams);
      });
    }
  }

  handleCancel() {
    this.isModalVisible = false;
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
