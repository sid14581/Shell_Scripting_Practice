#!/bin/bash

# Author: Siddharth

# Date Created: 11-07-2024
# Date Modified: 11-07-2024

# Usage and Description: Monitoring the System Processes and Memeory Usage


ps aux --sort=-%mem | head -n 10
