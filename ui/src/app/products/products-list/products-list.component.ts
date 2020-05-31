import { Component, OnInit } from '@angular/core';
import Product from '../product.entity';
import { ProductsService } from '../products.service';

@Component({
  selector: 'app-products-list',
  templateUrl: './products-list.component.html',
  styleUrls: ['./products-list.component.scss'],
})
export class ProductsListComponent implements OnInit {
  products: Product[];

  constructor(private productsService: ProductsService) {}

  ngOnInit(): void {
    this.productsService.loadProducts().subscribe((loadedProducts) => {
      this.products = loadedProducts;
    });
  }
}
