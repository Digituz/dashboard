## API Development Process

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

You need to run the migrations after creating a database:

```bash
cd api
ts-node ./node_modules/typeorm/cli.js migration:run
```

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

Using the API:

```bash
curl localhost:3000/v1/products

curl -X POST -H 'Content-Type: application/json' -d '{
  "sku": "LFK-0001",
  "title": "Máscara Frida Kahlo"
}' localhost:3000/v1/products

curl -X POST -H 'Content-Type: application/json' -d '{
  "sku": "LFK-0001-K",
  "description": "Kids"
}' localhost:3000/v1/products/LFK-0001/variation
```
