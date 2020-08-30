# Mercado Livre Instructions

## Getting Refresh and Access Token

Both the access and the refresh tokens are store on the `key_value_pair` (a helper table) table on PostgreSQL. If these tokens are not there, then, for the moment, you will have to get an authorization URL:

```bash
curl -X GET localhost:3005/v1/mercado-livre/authorize
```

Then use the URL returned to authorize the application and to get a `code` back. Unfortunately, the app on Mercado Livre is registered to redirect to the real domain, so you will need to intercept (dev tools) this URL and fetch the redirect URL to replace it with `http://localhost:3005/...`

Then, you can use `curl` to trigger the rest of the process:

```bash
curl http://localhost:3005/v1/mercado-livre\?code\=TG-5f46e0a3578a730006d292e0-632442748
```

## Getting a test user

Issuing a request like:

```bash
ACCESS_TOKEN="APP_USR-6962689565848218-082822-8f0863d90967436d8d931f9533fdb0ec-572387649"

curl -X POST -H "Content-Type: application/json" -d '{
  "site_id": "MLB"
}' https://api.mercadolibre.com/users/test_user?access_token=$ACCESS_TOKEN
```

Will get you an user like:

```json
// created on 2020-08-26
{
  "id": 632442748,
  "nickname": "TETE3170044",
  "password": "qatest1119",
  "site_status": "active",
  "email": "test_user_38092507@testuser.com"
}
```

After that, you can login with this user, authorize the application, and start creating test products.

## Getting Categories

```bash
curl -X GET https://api.mercadolibre.com/sites/MLB/categories

curl -X GET https://api.mercadolibre.com/categories/MLB1438
```

## Getting a Product

```bash
curl -X GET https://api.mercadolibre.com/items/MLB1361411457
```

## Migrating Products from Digituz to Mercado Livre

Triggering sync:

```bash
curl -X POST -H 'Authorization: Bearer '$DIGITUZ_TOKEN http://localhost:3005/v1/mercado-livre/
```

Deleting (delete) a product on Mercado Livre:

```bash
ITEM_ID=MLB-1642264358
ACCESS_TOKEN=APP_USR-6962689565848218-082822-8f0863d90967436d8d931f9533fdb0ec-572387649
curl -X DELETE https://api.mercadolibre.com/items/$ITEM_ID/description?access_token=$ACCESS_TOKEN
```