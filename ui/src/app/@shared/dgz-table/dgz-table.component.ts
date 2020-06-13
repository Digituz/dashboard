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
    this.loadData();
  }

  loadPage(pageNumber: number) {
    this.currentPage = pageNumber;
    this.loadData();
  }

  private loadData() {
    this.dataProvider.loadData(this.currentPage, this.pageSize, this.sortedBy, this.sortDirectionAscending).subscribe((response) => {
      this.currentData = response.items;
      this.totalItems = response.meta.totalItems;
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
