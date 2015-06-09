#!/bin/bash
# This script is to backup the web data
# /root/BackupScript/WEBList.txt

function rm_oldfile() {
    file=$1
    n=$2
    n1=$(ls -1 $file* | wc -l)
    n2=$(ls -1 $file* | tail -$n | wc -l)
    n3=$(expr $n1 - $n2)

    ls -1 $file* | head -n $n3 | xargs -n 1 rm -f
}

DATE=$(date +%Y%m%d-%H%M%S)

#WEB_DIR='/home/www/ccchen.com'
#WEB_DIR=""
while read line
do
    WEB_DIR="$line"
    WEB_PATH="/home/www"
    DATE=$(date +%Y%m%d-%H%M%S)
    BACKUP_PATH="/home/log/backup/WEB/$WEB_DIR"
    BACKUP_FILE="$BACKUP_PATH/ccchen_$WEB_DIR$DATE.tgz"

    if [ ! -d $BACKUP_PATH ]; then
        mkdir -p $BACKUP_PATH
    fi

    /bin/tar zcvf $BACKUP_FILE $WEB_PATH/$WEB_DIR > /dev/null 2>&1

    rm_oldfile $BACKUP_PATH/ 7

done < WEBList.txt
