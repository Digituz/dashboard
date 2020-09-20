# Backup the PostgreSQL Database

References:

- https://www.digitalocean.com/docs/spaces/resources/s3cmd/
- https://www.digitalocean.com/community/tutorials/how-to-automate-backups-digitalocean-spaces
- https://s3tools.org/download

We are using the `brunokrebs` user on the Digituz server. This user recorded a `crontab` script that calls `./backup-postgres.sh`.

## Restoring the PostgreSQL Database locally

To restore the PostgreSQL database, download one of the dumps from DigitalOcean (there is spaces called `digituz-backups` with all dumps under `digituz-backups`) and use the following commands:

```bash
# define what date are you interested in
DATE=20200920

# copy the gzipped file to a running container
docker cp $DATE-digituz-postgres.dump.tar.gz digituz-dashboard-postgres:/digituz-postgres.dump.tar.gz

# connect to it
docker exec -i -t digituz-dashboard-postgres /bin/bash

# extract the dump
tar -zxvf digituz-postgres.dump.tar.gz

# remove the previous database
PGPASSWORD=123 psql -U digituz-dashboard -d postgres -c 'drop database "digituz-dashboard";'
PGPASSWORD=123 psql -U digituz-dashboard -d postgres -c 'create database "digituz-dashboard";'

# restore the backup
PGPASSWORD=123 psql -U digituz-dashboard -d digituz-dashboard < digituz-postgres.dump

# leave the container
exit
```