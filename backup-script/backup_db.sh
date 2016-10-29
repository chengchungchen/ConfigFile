#!/bin/sh
#### This script is to backup the each DB and user privileges
#### It will include function file: ./funct.sh,
#### and loading backup file list: ./db_list.txt.
#### It will need DB password in ~/.my.cnf
#### Write by Cheng-Chung, Chen at 2016.09.11.

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
export PATH

#### Setting variables.
SCRIPT_ROOT="$(dirname $0)"
DATE="$(date +%Y%m%d-%H%M%S)"
BACKUP_TYPE="db"

#### Include function file.
. ${SCRIPT_ROOT}/funct.sh

#### Read the DB list, and backup it.
while read line
do
    DBNAME="${line}"
    BACKUP_PATH="/backup/${BACKUP_TYPE}/${DBNAME}"
    BACKUP_FILE="${BACKUP_PATH}/${DBNAME}-${DATE}.sql.gz"

    if [ ! -d ${BACKUP_PATH} ]; then
        mkdir -p ${BACKUP_PATH}
    fi

    mysqldump --default-character-set=utf8 --set-gtid-purged=OFF --opt --quick --triggers --routines --events ${DBNAME} | gzip > ${BACKUP_FILE}

    rm_oldfile ${BACKUP_PATH}/ 5
done < ${SCRIPT_ROOT}/db_list.txt

# Backup DB user privileges
if [ ! -d /backup/${BACKUP_TYPE}/user ]; then
    mkdir -p /backup/${BACKUP_TYPE}/user
fi

mysqldump --default-character-set=utf8 mysql columns_priv db procs_priv tables_priv user | gzip > /backup/${BACKUP_TYPE}/user/$(hostname)-dbuser-${DATE}.sql.gz

rm_oldfile $BACKUP_PATH/ 5
