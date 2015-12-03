#!/bin/bash
# This script is to backup the each DB and user privileges

function rm_oldfile() {
    file=$1
    n=$2
    n1=$(ls -1 $file* | wc -l)
    n2=$(ls -1 $file* | tail -$n | wc -l)
    n3=$(expr $n1 - $n2)

    ls -1 $file* | head -n $n3 | xargs -n 1 rm -f
}

DATE=$(date +%Y%m%d-%H%M%S)

# Read the DB list, and backup it.
while read line
do
    DBNAME="$line"
    BACKUP_PATH="/backup/DB/$DBNAME"
    BACKUP_FILE="$BACKUP_PATH/ccchen_$DBNAME$DATE.sql.bz2"

    if [ ! -d $BACKUP_PATH ]; then
        mkdir -p $BACKUP_PATH
    fi

    /usr/bin/mysqldump --default-character-set=utf8 --set-gtid-purged=OFF --opt --quick --triggers --routines --events $DBNAME | /bin/bzip2 > $BACKUP_FILE

    rm_oldfile $BACKUP_PATH/ 5
done < DBList.txt

# Backup DB user privileges
if [ ! -d /backup/DB/user ]; then
    mkdir -p /backup/DB/user
fi

/usr/bin/mysqldump --default-character-set=utf8 mysql columns_priv db procs_priv tables_priv user | /usr/bin/bzip2 > /backup/DB/user/ccchen_dbuser$DATE.sql.bz2

rm_oldfile $BACKUP_PATH/ 5
