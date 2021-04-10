import { ErrorHandler } from '@angular/core';
import { environment } from '@env/environment';
import { sendSlackAlert } from './util/slack-alert';

export class CustomErrorHandler implements ErrorHandler {
  handleError(error: any) {
    console.error(error);
    sendSlackAlert();
  }
}
