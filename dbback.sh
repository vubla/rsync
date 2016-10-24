#!/bin/bash


ssh 11895@ch-s011.rsync.net cp database/prime2.sql.tgz database/prime3.sql.tgz
ssh 11895@ch-s011.rsync.net cp database/prime1.sql.tgz database/prime2.sql.tgz

cd /root/rsync/
rm *.tgz
rm *.sql


mysqldump -ubackup -pPZNMb4MKqTTB5WpQ --all-databases --quick  > prime1.sql

tar -cvzf prime1.sql.tgz  prime1.sql

rsync -avz prime1.sql 11895@ch-s011.rsync.net:database
rsync -avz prime1.sql.tgz 11895@ch-s011.rsync.net:database

#rm *.tgz 
#rm *.sql
