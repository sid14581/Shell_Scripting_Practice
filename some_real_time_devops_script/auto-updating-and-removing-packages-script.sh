#!/bin/bash

# Author: Siddharth Reddy

# Usage: Updating and Cleaning Packages

# Date Created: 09-07-2024
# Date Modified: 09-07-2024

# Description: Auto updating and Auto clean the packages in the  system

######################################################################################


sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y  && sudo apt-get autoclean

if [[ "$?" -eq 0  ]]; then
	echo "Packages are auto updated and auto cleaned."
fi
