#!/bin/bash

###########################################################################################################
## 
##  Author: K Siddharth Reddy
##
##  Date Created: 07-11-2024
##  Date Modified: 07-28-2024
##
##  Usage: database backup
##  Description: Backuping the database in the backup folderr with backup  date and time
##
################################################################################################


SRC="/home/ubuntu/Shell_Scripting_Practice/some_real_time_devops_script/"
DES="/home/ubuntu/Shell_Scripting_Practice/backup_script_destination/"

DATE=$(date +%Y-%m-%d-%T)

backup="$DES/$DATE"

cp -r $SRC $backup


backups=($(ls ../backup_script_destination/ -t))

echo " "
echo "List of the backups-->"
for backup in "${backups[@]}"; do  
   echo "${backup}"
done
echo " "

if [[ "${#backups[@]}" -gt 5 ]]; then
  for backup in "${backups[@]:5}"; do 
       echo "backup file $backup is removed "
       rm -dfr "../backup_script_destination/$backup"
  done
fi
echo " "
echo "new backup file ${backups[0]} is added"
echo " "

backups=($(ls ../backup_script_destination/ -t))

echo " "
echo "List of the backups-->"
for backup in "${backups[@]}"; do
   echo "${backup}"
done
echo " "
