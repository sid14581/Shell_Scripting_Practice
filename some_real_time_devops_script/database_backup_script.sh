#!/bin/bash

# Author: Siddharth

# Date Created: 07-11-2024
# Date Modified: 07-11-2024

# Usage: database backup
# Description: Backuping the database in the backup folderr with backup  date and time

################################################################################################


pwdd=$(pwd)

db_name="mysql"
DATE=$(date +%m-%d-%Y-%T)
backup_dir="/database_backup/"
dbbackup=$pwdd$backup_dir$DATE

mkdir -p $dbbackup

mysqldump -u root -p $db_name > "$dbbackup/backup-$DATE-db.sql"

echo "$db_name database is backed up in $backup_dir folder"
