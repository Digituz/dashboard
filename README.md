## API Development Process

```bash
docker run --name digituz-dashboard-mysql \
    -p 3306:3306 \
    -e MYSQL_ROOT_PASSWORD=myextremellysecretpassword \
    -e MYSQL_DATABASE=digituz-dashboard \
    -e MYSQL_USER=digituz-dashboard \
    -e MYSQL_PASSWORD=mysecretpassword \
    -d mysql:5.7

docker stop digituz-dashboard-mysql
docker rm digituz-dashboard-mysql
```
