import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MlErrosListComponent } from './ml-erros-list.component';

describe('MlErrosListComponent', () => {
  let component: MlErrosListComponent;
  let fixture: ComponentFixture<MlErrosListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [MlErrosListComponent],
    }).compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(MlErrosListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
