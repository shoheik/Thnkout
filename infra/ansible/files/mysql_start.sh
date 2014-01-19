#!/bin/bash

PASS='3dDd9d983dafdmvznc9'
DB='thnkout_test'

/etc/init.d/mysqld start 
/usr/bin/mysqladmin -u root password $PASS 
/usr/bin/mysql -u root -p$PASS -e"CREATE DATABASE $DB"
/usr/bin/mysql -u root -p$PASS -e"grant all privileges on thnkout_test.* to thnkout@localhost identified by 'thnkout'";

