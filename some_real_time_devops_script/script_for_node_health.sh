#!/bin/bash

# Author: Siddharth

# Date Created: 09-07-2024    # Date Updated: 09-07-2024

# Usage: Analysing Node Health

# Description:  Analyzing the node health by checking the CPU processes and  Disk Usage 


############################################################################################################


set -x


nproc


free -h


df -h

ps aux | grep "nginx" 


ps -ef | grep "nginx"

