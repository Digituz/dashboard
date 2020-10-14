import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { CustomersReportComponent } from './customers-report.component';

describe('CustomersReportComponent', () => {
  let component: CustomersReportComponent;
  let fixture: ComponentFixture<CustomersReportComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [CustomersReportComponent],
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CustomersReportComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
