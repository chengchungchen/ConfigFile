#!/bin/bash
# This script is to backup the DB

DATE=$(date +%Y%m%d-%H%M%S)
BACKUP_PATH='/home/log/backup/DB'
BACKUP_FILE=$BACKUP_PATH/smartblog_DB$DATE.sql.bz2

if [ ! -d $BACKUP_PATH ]; then
	mkdir -p $BACKUP_PATH
fi

starttime=$(date +%H%M%S)
echo $starttime
/usr/bin/mysqldump -u root -pdbpasswd --default-character-set=utf8 --opt --quick --all-databases | /bin/bzip2 > $BACKUP_FILE 
endtime=$(date +H%M%S)
echo $endtime

function rm_oldfile() {
	file=$1
	n=$2
	n1=$(ls -1 $file* | wc -l)
	n2=$(ls -1 $file* | tail -$n | wc -l)
	n3=$(expr $n1 - $n2)

	ls -1 $file* | head -n $n3 | xargs -n 1 rm -f
}

rm_oldfile $BACKUP_PATH/ 21
