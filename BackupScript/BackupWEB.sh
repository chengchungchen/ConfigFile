#!/bin/bash
# This script is to backup the web data
# /root/BackupScript/WEBList.txt

WEB_DIR='/home/www/ccchen.com'

DATE=$(date +%Y%m%d-%H%M%S)
BACKUP_PATH='/home/log/backup/WEB'
BACKUP_FILE=$BACKUP_PATH/ccchen_WEB$DATE.tgz

if [ ! -d $BACKUP_PATH ]; then
	mkdir -p $BACKUP_PATH
fi

/bin/tar zcvf $BACKUP_FILE $WEB_DIR > /dev/null 2>&1

function rm_oldfile() {
	file=$1
	n=$2
	n1=$(ls -1 $file* | wc -l)
	n2=$(ls -1 $file* | tail -$n | wc -l)
	n3=$(expr $n1 - $n2)

	ls -1 $file* | head -n $n3 | xargs -n 1 rm -f
}

rm_oldfile $BACKUP_PATH/ 7
