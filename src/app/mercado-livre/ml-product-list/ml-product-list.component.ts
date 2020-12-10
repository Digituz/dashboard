import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-ml-product-list',
  templateUrl: './ml-product-list.component.html',
  styleUrls: ['./ml-product-list.component.scss'],
})
export class MlProductListComponent implements OnInit {
  constructor(private route: ActivatedRoute) {
    console.log(this.route.snapshot.queryParams.token);
  }

  ngOnInit(): void {}
}
