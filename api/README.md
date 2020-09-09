# API Development Process

This project is based on [Nest.js](https://docs.nestjs.com/).

To start developing, you need at least three things:

1. Install the dependencies
2. Configure a local database
3. Run the app

These three steps are covered in sequence below.

## Installation

```bash
# install the dependencies of this project
npm install

# for the migrations (more on that below)
npm i -g ts-node
```

## The Database (PostgreSQL)

Creating a local database with Docker:

```bash
docker run --name digituz-dashboard-postgres \
    -p 5432:5432 \
    -e POSTGRES_DB=digituz-dashboard \
    -e POSTGRES_USER=digituz-dashboard \
    -e POSTGRES_PASSWORD=123 \
    -d postgres:12.3-alpine

docker stop digituz-dashboard-postgres
docker rm digituz-dashboard-postgres
```

To copy the backup, you can issue the following command:

```bash
docker cp bin/bkp/digituz-2020-09-08.dump digituz-dashboard-postgres:/digituz-2020-09-08.dump
docker exec -i -t digituz-dashboard-postgres /bin/bash
psql --user digituz-dashboard digituz-dashboard < digituz-2020-09-08.dump
```

## Running the app

```bash
# development
$ npm run start

# watch mode
$ npm run start:dev

# production mode
$ npm run start:prod
```

## Database Migrations

You need to run the migrations after creating a database:

```bash
cd api
ts-node ./node_modules/typeorm/cli.js migration:run
```

## Querying the Database Directly

Connecting to the database:

```bash
# getting inside the docker instace
docker exec -i -t digituz-dashboard-postgres /bin/bash

# from within the docker instance, connect to the databse
psql --user digituz-dashboard digituz-dashboard

# run your queries
select * from product;

# (danger) clean up table
truncate table product;
```

## Authentication

```bash
# sign in
curl -X POST http://localhost:3005/v1/sign-in -d '{"username": "bruno.krebs@fridakahlo.com.br", "password": "lbX01as$"}' -H "Content-Type: application/json"

# copy the token from the command above
JWT=eyJ...Zxk

# use the token on other requests
curl -H 'Authorization: Bearer '$JWT localhost:3005/v1/profile
```

## Interacting with the API

Using the API. For the moment, they all need JWTs. So, check the instructions above, then execute the following commands:

```bash
curl -H 'Authorization: Bearer '$JWT localhost:3005/v1/products

curl -X POST -H 'Authorization: Bearer '$JWT -H 'Content-Type: application/json' -d '{
  "sku": "LFK-0001",
  "title": "Máscara Frida Kahlo"
}' localhost:3005/v1/products

curl -X POST -H 'Authorization: Bearer '$JWT -H 'Content-Type: application/json' -d '{
  "parentSku": "LFK-0001",
  "sku": "LFK-0001-K",
  "description": "Kids"
}' localhost:3005/v1/products/variations

curl -X POST -H 'Authorization: Bearer '$JWT -H 'Content-Type: application/json' -d '{
  "parentSku": "LFK-0001",
  "sku": "LFK-0001-K",
  "description": "4 Kids"
}' localhost:3005/v1/products/variations

curl -X POST -H 'Authorization: Bearer '$JWT -H 'Content-Type: application/json' -d '{
  "parentSku": "LFK-0001",
  "sku": "LFK-0001-M",
  "description": "4 Men"
}' localhost:3005/v1/products/variations

curl -X POST -H 'Authorization: Bearer '$JWT -H 'Content-Type: application/json' -d '{
  "parentSku": "LFK-0001",
  "sku": "LFK-0001-W",
  "description": "4 Women"
}' localhost:3005/v1/products/variations
```

## API Test

To create the test database, run the following commands:

```sql
CREATE DATABASE "digituz-dashboard-test";
GRANT ALL PRIVILEGES ON DATABASE "digituz-dashboard-test" TO "digituz-dashboard";
```

After that, change the `TYPEORM_URL` variable (on the `.env` file on the `api` dir, not on the `api/test`) to point to this test database:

```text
TYPEORM_URL=postgres://digituz-dashboard:123@localhost:5432/digituz-dashboard-test
```

Then run the migrations:

```bash
# from the api dir
ts-node ./node_modules/typeorm/cli.js migration:run
```

With that in place, just run the tests:

```bash
npm test
```