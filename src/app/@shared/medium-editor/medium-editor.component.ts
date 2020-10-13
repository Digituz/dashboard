import {
  Component,
  OnInit,
  ElementRef,
  ViewChild,
  AfterViewInit,
  EventEmitter,
  Output,
  OnChanges,
  ɵlooseIdentical,
  Input,
  OnDestroy,
} from '@angular/core';

declare var MediumEditor: any;

@Component({
  selector: 'medium-editor',
  templateUrl: './medium-editor.component.html',
  styleUrls: ['./medium-editor.component.scss'],
})
export class MediumEditorComponent implements OnInit, AfterViewInit, OnChanges, OnDestroy {
  private lastViewModel: string;
  editor: any;
  @ViewChild('editable', {
    static: true,
  })
  editable: ElementRef;
  @Input('editorModel') model: any;
  @Output('editorModelChange') update = new EventEmitter();
  @Input('placeholder') placeholder: string;

  constructor() {}

  ngOnInit(): void {}

  ngAfterViewInit() {
    this.editor = new MediumEditor(this.editable.nativeElement, {
      placeholder: {
        text: this.placeholder || 'Digite um texto.',
        hideOnClick: false,
      },
    });
    this.refreshView();
    this.editor.subscribe('editableInput', () => {
      this.updateModel();
    });
  }

  ngOnChanges(changes: any): void {
    if (this.isPropertyUpdated(changes, this.lastViewModel)) {
      this.lastViewModel = this.model;
      this.refreshView();
    }
  }

  updateModel(): void {
    let value = this.editor.getContent();
    value = value
      .replace(/&nbsp;/g, '')
      .replace(/<p><br><\/p>/g, '')
      .trim();
    this.lastViewModel = value;
    this.update.emit(value);
  }

  /**
   * Remove MediumEditor on destruction of directive
   */
  ngOnDestroy(): void {
    this.editor.destroy();
  }

  isPropertyUpdated(changes: any, viewModel: any) {
    if (!changes.hasOwnProperty('model')) {
      return false;
    }

    const change = changes.model;

    if (change.isFirstChange()) {
      return true;
    }
    return !ɵlooseIdentical(viewModel, change.currentValue);
  }

  refreshView() {
    if (this.editor) {
      this.editor.setContent(this.model);
    }
  }
}
