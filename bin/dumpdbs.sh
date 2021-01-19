#!/bin/bash

# for x in `echo "show databases;" | mysql -u root -ppassword| egrep -v "Database|information_schema|mysql"`; do mysqldump -u root -ppassword --extended=FALSE --compact --single-transaction --quick --skip-extended-insert $x | egrep -h "[[:graph:]]+@[[:graph:]]+" >> $x; done

MYSQL_USER=root
MYSQL_PASS=password
MYSQL_CONN="-u${MYSQL_USER} -p${MYSQL_PASS}"
SQLSTMT="SELECT CONCAT(table_schema,'.',table_name)"
SQLSTMT="${SQLSTMT} FROM information_schema.tables WHERE table_schema NOT IN "
SQLSTMT="${SQLSTMT} ('information_schema','performance_schema','mysql')"
mysql ${MYSQL_CONN} -ANe"${SQLSTMT}" > /tmp/DBTB.txt
COMMIT_COUNT=0
COMMIT_LIMIT=10
for DBTB in `cat /tmp/DBTB.txt`
do
    DB=`echo "${DBTB}" | sed 's/\./ /g' | awk '{print $1}'`
    TB=`echo "${DBTB}" | sed 's/\./ /g' | awk '{print $2}'`
    DUMPFILE=${DB}-${TB}.csv.gz
		mysql ${MYSQL_CONN} -ANe"SELECT * from ${TB}" ${DB} | egrep -h "[[:graph:]]+@[[:graph:]]+" | gzip > ${DUMPFILE}
    (( COMMIT_COUNT++ ))
    if [ ${COMMIT_COUNT} -eq ${COMMIT_LIMIT} ]
    then
        COMMIT_COUNT=0
        wait
    fi
done
if [ ${COMMIT_COUNT} -gt 0 ]
then
    wait
fi

