#!/bin/bash

SRC="/home/sid/Documents/my_jenkins_project/Small-scale-urban-services/"
DES="/home/sid/linux_real_time_devops_work/backup_script_destination"

DATE=$(date +%Y-%m-%d-%T)

backup="$DES/$DATE"

cp -r $SRC $backup


