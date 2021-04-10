import { environment } from '@env/environment';

export function sendSlackAlert(message: string = 'Houve um erro inesperado') {
  const url = environment.production
    ? 'https://hooks.slack.com/services/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'
    : 'https://hooks.slack.com/services/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';

  const formatedMessage = {
    text: 'Falha em Digituz Dashboard',
    attachments: [
      {
        text: message,
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
    body: JSON.stringify(formatedMessage),
  })
    .then(() => console.log('sucesso'))
    .catch((err) => console.log(err));
}
