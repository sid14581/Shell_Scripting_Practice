#!/bin/bash

# Author: Siddharth
# Date Created: 07-11-2024
# Date Modified: 07-11-2024

# Usage: Disk Usage
# Description: Checking the disk usage in the system

########################################################################


LIMIT=1

df -h | grep -vE '^Filesystem|tmpfs|cdrom' | awk -F " " '{print $1" "$5 }' |
	while read output ;
	do
		usage=$(echo $output | awk -F " " '{print $2}' | cut -d "%" -f 1 )	
		partition=$(echo $output | awk -F " " '{print $1}')
		if [[ $usage -ge $LIMIT ]]; then
			echo "disk usage for $partition is $usage"
	        fi
       done;
