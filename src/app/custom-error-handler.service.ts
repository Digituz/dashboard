import { HttpClient } from '@angular/common/http';
import { ErrorHandler, Injectable } from '@angular/core';
import { environment } from '@env/environment';

export class CustomErrorHandler implements ErrorHandler {
  handleError(error: any) {
    console.error(error);
    console.log('aqui');
    const message = 'Ouve um erro inesperado, para mais informações acesse o datadog';
    const url = environment.production
      ? 'https://hooks.slack.com/services/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'
      : 'https://hooks.slack.com/services/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';

    fetch(url, {
      mode: 'no-cors',
      method: 'POST',
      headers: {
        Accept: 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Access-Control-Allow-Origin': '*',
      },
      body: JSON.stringify({ text: message }),
    })
      .then(() => console.log('sucesso'))
      .catch((err) => console.log(err));
  }
}
