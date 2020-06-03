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

## The Database (MySQL)

Creating a local database with Docker:

```bash
docker run --name digituz-dashboard-mysql \
    -p 3306:3306 \
    -e MYSQL_ROOT_PASSWORD=myextremellysecretpassword \
    -e MYSQL_DATABASE=digituz-dashboard \
    -e MYSQL_USER=digituz-dashboard \
    -e MYSQL_PASSWORD=123456 \
    -d mysql:5.7

docker stop digituz-dashboard-mysql
docker rm digituz-dashboard-mysql
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
docker exec -i -t digituz-dashboard-mysql /bin/bash

# from within the docker instance, connect to the databse
mysql --user digituz-dashboard --database digituz-dashboard --password

# run your queries
select * from product;

# (danger) clean up table
truncate table product;
```

## Interacting with the API

Using the API:

```bash
curl localhost:3000/v1/products

curl -X POST -H 'Content-Type: application/json' -d '{
  "sku": "LFK-0001",
  "title": "Máscara Frida Kahlo"
}' localhost:3000/v1/products

curl -X POST -H 'Content-Type: application/json' -d '{
  "parentSku": "LFK-0001",
  "sku": "LFK-0001-K",
  "description": "Kids"
}' localhost:3000/v1/products/variations

curl -X POST -H 'Content-Type: application/json' -d '{
  "parentSku": "LFK-0001",
  "sku": "LFK-0001-K",
  "description": "4 Kids"
}' localhost:3000/v1/products/variations

curl -X POST -H 'Content-Type: application/json' -d '{
  "parentSku": "LFK-0001",
  "sku": "LFK-0001-M",
  "description": "4 Men"
}' localhost:3000/v1/products/variations

curl -X POST -H 'Content-Type: application/json' -d '{
  "parentSku": "LFK-0001",
  "sku": "LFK-0001-W",
  "description": "4 Women"
}' localhost:3000/v1/products/variations
```

## Authentication

```bash
# sign in
curl -X POST http://localhost:3000/v1/sign-in -d '{"username": "john", "password": "changeme"}' -H "Content-Type: application/json"

# copy the token from the command above
JWT=eyJ...Zxk

# use the token on other requests
curl -H 'Authorization: Bearer '$JWT localhost:3000/v1/profile
```