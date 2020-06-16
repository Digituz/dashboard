import { Directive, ElementRef, Renderer2, OnInit } from '@angular/core';

@Directive({
  selector: '[dgz-sortable]',
})
export class DgzSortableDirective implements OnInit {
  constructor(private el: ElementRef, private renderer: Renderer2) {}

  ngOnInit(): void {
    const innerHTML = this.el.nativeElement.innerHTML;
    const arrowDown = `<i class="anticon ant-table-column-sorter-down anticon-caret-down ng-star-inserted"><svg viewBox="0 0 1400 1400" focusable="false" fill="currentColor" width="1em" height="1em" data-icon="caret-down" aria-hidden="true"><path d="M840.4 300H183.6c-19.7 0-30.7 20.8-18.5 35l328.4 380.8c9.4 10.9 27.5 10.9 37 0L858.9 335c12.2-14.2 1.2-35-18.5-35z"></path></svg></i>`;
    const arrowUp = `<i class="anticon ant-table-column-sorter-up anticon-caret-up ng-star-inserted"><svg viewBox="0 0 1400 1400" focusable="false" fill="currentColor" width="1em" height="1em" data-icon="caret-up" aria-hidden="true"><path d="M858.9 689L530.5 308.2c-9.4-10.9-27.5-10.9-37 0L165.1 689c-12.2 14.2-1.2 35 18.5 35h656.8c19.7 0 30.7-20.8 18.5-35z"></path></svg></i>`;
    const arrowsContainer = `<span class="ant-table-column-sorter ant-table-column-sorter-full"><span class="ant-table-column-sorter-inner">${arrowUp}${arrowDown}</span></span>`;
    this.el.nativeElement.innerHTML = `${innerHTML}${arrowsContainer}`;
  }
}
