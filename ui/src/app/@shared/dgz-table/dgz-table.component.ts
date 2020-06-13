import { Component, OnInit, Input } from '@angular/core';
import { IDataProvider } from '@app/util/pagination';

@Component({
  selector: 'dgz-table',
  templateUrl: './dgz-table.component.html',
  styleUrls: ['./dgz-table.component.scss']
})
export class DgzTableComponent<T> implements OnInit {
  @Input()
  dataProvider: IDataProvider<T>;
  currentData: T[] = [];
  currentPage: number = 1;
  pageSize: number = 10;
  sortedBy: string;
  sortDirectionAscending: boolean;
  totalItems: number = 0;

  constructor() { }

  ngOnInit(): void {
    this.dataProvider.loadData(this.currentPage, this.pageSize).subscribe((response) => {
      this.currentData = response.items;
      this.totalItems = response.meta.totalItems;
    });
  }

  loadPage(pageNumber: number) {
    this.currentPage = pageNumber;

    this.dataProvider.loadData(this.currentPage, this.pageSize).subscribe((response) => {
      this.currentData = response.items;
      this.totalItems = response.meta.totalItems;
    });
  }

  sortTable($event: Event) {
    console.log($event.target);
  }
}
