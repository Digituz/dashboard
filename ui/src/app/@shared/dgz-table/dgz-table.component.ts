import { Component, Input, OnInit, Output, EventEmitter } from '@angular/core';
import { IDataProvider, QueryParam } from '@app/util/pagination';
import { delay } from 'rxjs/operators';
import { FilterCacheService } from '@app/filter-cache.service';

@Component({
  selector: 'dgz-table',
  templateUrl: './dgz-table.component.html',
  styleUrls: ['./dgz-table.component.scss'],
})
export class DgzTableComponent<T> implements OnInit {
  @Input()
  dataProvider: IDataProvider<T>;

  @Input()
  queryParams: QueryParam[];

  @Output() updateQueryParams = new EventEmitter<QueryParam[]>();

  @Input()
  name: string;

  loading: boolean = false;
  currentData: T[] = [];
  currentPage: number = 1;
  numberOfPages: number = 1;
  pageSize: number = 10;
  sortedBy: string;
  sortDirectionAscending: boolean;
  totalItems: number = 0;

  constructor(private filterCacheService: FilterCacheService) {}

  ngOnInit() {
    const savedParams = this.filterCacheService.get(this.name);
    if (savedParams) {
      this.currentPage = savedParams.currentPage;
      this.pageSize = savedParams.pageSize;
      this.sortedBy = savedParams.sortedBy;
      this.sortDirectionAscending = savedParams.sortDirectionAscending;
      this.queryParams = savedParams.queryParams;
    }
    this.loadData();
  }

  reload(queryParams: QueryParam[]): void {
    this.queryParams = queryParams;
    this.currentPage = 1;
    this.loadData();
  }

  loadPage(pageNumber: number) {
    this.currentPage = pageNumber;
    this.loadData();
  }

  loadData() {
    this.filterCacheService.set(this.name, {
      currentPage: this.currentPage,
      pageSize: this.pageSize,
      sortedBy: this.sortedBy,
      sortDirectionAscending: this.sortDirectionAscending,
      queryParams: this.queryParams,
    });
    this.loading = true;
    this.dataProvider
      .loadData(this.currentPage, this.pageSize, this.sortedBy, this.sortDirectionAscending, this.queryParams)
      .pipe(delay(350))
      .subscribe((response) => {
        this.currentData = response.items;
        this.totalItems = response.meta.totalItems;
        this.numberOfPages = Math.ceil(this.totalItems / this.pageSize);
        this.loading = false;
        this.updateQueryParams.emit(this.queryParams);
      });
  }

  sortTable(target: Element) {
    let sortableItem = target;
    while (!!sortableItem && (!sortableItem.attributes || !sortableItem.attributes.getNamedItem('dgz-sortable'))) {
      sortableItem = sortableItem.parentElement;
    }
    if (!sortableItem) return;
    const newSortedAttribute = sortableItem.attributes.getNamedItem('dgz-sortable').value;
    this.sortDirectionAscending = newSortedAttribute !== this.sortedBy || this.sortDirectionAscending === false;
    this.sortedBy = newSortedAttribute;
    this.loadData();
  }

  nextPage() {
    if (this.currentPage >= this.numberOfPages) return;
    this.currentPage++;
    this.loadData();
  }

  previousPage() {
    if (this.currentPage <= 1) return;
    this.currentPage--;
    this.loadData();
  }
}
