import { Directive, ElementRef, Renderer2, OnInit } from '@angular/core';

@Directive({
  selector: '[dgz-sortable]',
})
export class DgzSortableDirective implements OnInit {
  constructor(private el: ElementRef, private renderer: Renderer2) {}

  ngOnInit(): void {
    const innerHTML = this.el.nativeElement.innerHTML;
    const arrowsContainer = `<i style="margin-left: 5px; font-size: 10px;" class="fas fa-sort"></i>`;
    this.el.nativeElement.innerHTML = `${innerHTML}${arrowsContainer}`;
  }
}
