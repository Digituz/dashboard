get sales orders from Bling after a date (`dataEmissao`):

```bash
export BLING_APIKEY=50c467c88f5cb2b8021c7f8818a8d4b22df7a80dc29fbe1f533b0ce6c2e1cfaa7581fbc8

curl -X GET "https://bling.com.br/Api/v2/pedidos/json/?apikey="$BLING_APIKEY"&filters=dataEmissao%5B01%2F08%2F2020%20TO%2023%2F08%2F2020%5D%3B%20idSituacao%5B21%5D"
```