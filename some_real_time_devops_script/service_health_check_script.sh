#!/bin/bash

# Author: Siddharth

# Date Created: 07-11-2024
# Date Modified: 07-11-2024

# Usage &  Description: Check whether the service is running or not.

service=nginx

if systemctl is-active --quiet $service
then
	echo "service is running"
else
	echo "service is not running"
	sudo systemctl restart $service
fi

