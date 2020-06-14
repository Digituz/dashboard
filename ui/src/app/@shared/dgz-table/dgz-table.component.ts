import { Component, OnInit, Input, OnChanges, SimpleChanges } from '@angular/core';
import { IDataProvider, QueryParam } from '@app/util/pagination';
import { delay } from 'rxjs/operators';

@Component({
  selector: 'dgz-table',
  templateUrl: './dgz-table.component.html',
  styleUrls: ['./dgz-table.component.scss']
})
export class DgzTableComponent<T> implements OnInit, OnChanges {
  @Input()
  dataProvider: IDataProvider<T>;

  @Input()
  queryParams: QueryParam[];

  loading: boolean = false;
  currentData: T[] = [];
  currentPage: number = 1;
  pageSize: number = 10;
  sortedBy: string;
  sortDirectionAscending: boolean;
  totalItems: number = 0;

  constructor() { }

  ngOnChanges(changes: SimpleChanges): void {
    this.currentPage = 1;
    this.loadData();
  }

  ngOnInit(): void {
    this.loadData();
  }

  loadPage(pageNumber: number) {
    this.currentPage = pageNumber;
    this.loadData();
  }

  private loadData() {
    this.loading = true;
    this.dataProvider.loadData(this.currentPage, this.pageSize, this.sortedBy, this.sortDirectionAscending, this.queryParams)
    .pipe(
      delay(250)
    )
    .subscribe((response) => {
      this.currentData = response.items;
      this.totalItems = response.meta.totalItems;
      this.loading = false;
    });
  }

  sortTable(target: Element) {
    let sortableItem = target;
    while (!sortableItem.attributes || !sortableItem.attributes.getNamedItem("dgz-sortable")) {
      sortableItem = sortableItem.parentElement;
    }
    const newSortedAttribute = sortableItem.attributes.getNamedItem("dgz-sortable").value;
    this.sortDirectionAscending = newSortedAttribute !== this.sortedBy || this.sortDirectionAscending === false;
    this.sortedBy = newSortedAttribute;
    this.loadData();
  }
}
