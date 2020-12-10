import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MlProductListComponent } from './ml-product-list.component';

describe('MlProductListComponent', () => {
  let component: MlProductListComponent;
  let fixture: ComponentFixture<MlProductListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [MlProductListComponent],
    }).compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(MlProductListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
