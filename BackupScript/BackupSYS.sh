#!/bin/bash
# This script is to backup the system configure from
# /root/BackupScript/SYSList.txt

#FILE='/etc/nginx/fastcgi_params /etc/nginx/nginx.conf /etc/nginx/sites-available /etc/php5/fpm/php-fpm.conf /etc/php5/fpm/php.ini /etc/php5/fpm/pool.d/www.conf /usr/share/php /etc/mysql/my.cnf /etc/mysql/conf.d/yam.cnf /etc/logrotate.d/mysql-server /etc/logrotate.d/nginx /etc/logrotate.d/php5-fpm /etc/pure-ftpd/pureftpd.passwd /etc/pure-ftpd/conf/PassivePortRange /etc/pure-ftpd/conf/NoAnonymous /etc/cron.d /root/BackupScript /etc/sysctl.conf'

FILE=""
while read line
do
    FILE="$FILE $line"
done < CentOSSYSList.txt

DATE=$(date +%Y%m%d-%H%M%S)
BACKUP_PATH='/home/log/backup/SYS'
BACKUP_FILE=$BACKUP_PATH/ccchen_SYS$DATE.tgz

if [ ! -d $BACKUP_PATH ]; then
    mkdir -p $BACKUP_PATH
fi

/bin/tar zcvf $BACKUP_FILE $FILE > /dev/null 2>&1

function rm_oldfile() {
    file=$1
    n=$2
    n1=$(ls -1 $file* | wc -l)
    n2=$(ls -1 $file* | tail -$n | wc -l)
    n3=$(expr $n1 - $n2)

    ls -1 $file* | head -n $n3 | xargs -n 1 rm -f
}

rm_oldfile $BACKUP_PATH/ 7
