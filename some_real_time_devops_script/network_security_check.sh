#!/bin/bash

# author: Siddharth

# Date Modified: 11-07-2024
# Date Created: 11-07-2024

# Usage & Decription : Checking the whether the website is reachable or not.

#######################################################################################################


web=$1

pwdd=$(pwd)

ping -c 2 $web &> /dev/null

if [[ "$?" -eq 0 ]];
then
	echo "$web is reachable" >> $pwdd/network.txt
else
	echo "$web is not reachable" >> $pwdd/network.txt
fi

