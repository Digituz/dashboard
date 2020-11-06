import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PurchaseOrdersFormComponent } from './purchase-orders-form.component';

describe('PurchaseOrdersFormComponent', () => {
  let component: PurchaseOrdersFormComponent;
  let fixture: ComponentFixture<PurchaseOrdersFormComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [PurchaseOrdersFormComponent],
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PurchaseOrdersFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
