import { ErrorHandler } from '@angular/core';
import { environment } from '@env/environment';

export class CustomErrorHandler implements ErrorHandler {
  handleError(error: any) {
    console.error(error);

    const url = environment.production
      ? 'https://hooks.slack.com/services/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'
      : 'https://hooks.slack.com/services/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';

    const message = {
      text: 'Falha na Digituz Dashboard',
      attachments: [
        {
          text: 'Houve um erro inesperado',
          fallback: 'Não a erro',
          callback_id: 'wopr_game',
          color: '#3AA3E3',
          attachment_type: 'default',
          actions: [
            {
              name: 'goDatadog',
              text: 'Ir para os logs do datadog',
              style: 'danger',
              type: 'button',
              value: 'war',
              url: 'https://app.datadoghq.com/logs?index=%2A&query=',
            },
          ],
        },
      ],
    };

    fetch(url, {
      mode: 'no-cors',
      method: 'POST',
      headers: {
        Accept: 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Access-Control-Allow-Origin': '*',
      },
      body: JSON.stringify(message),
    })
      .then(() => console.log('sucesso'))
      .catch((err) => console.log(err));
  }
}
