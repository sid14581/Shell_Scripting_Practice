#!/bin/bash

##############################################################################################
##
## Author: Siddharth
##
## Date Created: 07-11-2024
## Date Modified: 07-28-2024
##
## Usage: database backup
## Description: Backuping the database in the backup folderr with backup  date and time
##
################################################################################################


pwdd="/home/ubuntu/Shell_Scripting_Practice"

db_name="mysql"
DATE=$(date +%m-%d-%Y-%T)
backup_dir="/database_backup/"
dbbackup="$pwdd$backup_dir$DATE"

sudo mkdir -p $dbbackup

sudo sudo chown -R ubuntu:ubuntu $dbbackup

mysqldump -u root -p $db_name > "$dbbackup/backup-$DATE-db.sql"

echo "$db_name database is backed up in $backup_dir folder"
echo " "

db_backups=($(ls ./../database_backup/ -t))

for db_backup in "${db_backups[@]}"; do
    echo "$db_backup"
done

echo " "

if [[ ${#db_backups[@]} -gt 5 ]]; then
	for db_backup in "${db_backups[@]:5}"; do
		echo "DB file $db_backup is removed"
                sudo rm -drf "./../database_backup/$db_backup"
	done
fi

echo "DB file ${db_backups[0]} is added"
echo " "

db_backups=($(ls ./../database_backup/ -t))

for db_backup in "${db_backups[@]}"; do
     echo "$db_backup"
done

echo " "
