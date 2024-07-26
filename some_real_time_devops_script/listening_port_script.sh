#!/bin/bash

# AUTHOR: Siddharth

# Date Created: 07-11-2024
# Date Modified: 07-11-2024

# Usage: Listening Ports
# Description: Genearating all the listing ports with netstat


netstat -tunl | grep "LISTEN"
