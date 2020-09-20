#!/bin/bash

DATE=`date +%Y%m%d`

dumpAndPackPostgres() {
    echo "\n##### Dumping and Packing Digituz Database #####\n"
    cd /home/brunokrebs/digituz-backups/
    PGPASSWORD=ZRynpioC4Zzt8MeR \
        pg_dump -U brunokrebs -d digituz > digituz-postgres.dump
    tar -czvf $DATE-digituz-postgres.dump.tar.gz digituz-postgres.dump
    rm digituz-postgres.dump
}

moveToSpace() {
    echo "\n##### Moving the backup file to DigitalOcean Spaces #####\n"
    cd /home/brunokrebs/digituz-backups/
    s3cmd put $DATE-digituz-postgres.dump.tar.gz s3://digituz-backups/postgresql/
}

dumpAndPackPostgres && moveToSpace
