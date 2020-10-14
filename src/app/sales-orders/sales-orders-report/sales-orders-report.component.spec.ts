import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { SalesOrdersReportComponent } from './sales-orders-report.component';

describe('SalesOrdersReportComponent', () => {
  let component: SalesOrdersReportComponent;
  let fixture: ComponentFixture<SalesOrdersReportComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [SalesOrdersReportComponent],
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SalesOrdersReportComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
