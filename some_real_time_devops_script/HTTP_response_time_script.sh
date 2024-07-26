#!/bin/bash

# AUTHOR: Siddharth

# Date Created: 07-11-2024
# Date Modified: 07-11-2024

# Usage: Response Time of the Websites
# Description: Genearating the response  time taken( in seconds) by the websites


URLS=("https://www.google.com", "https://www.facebook.com", "https://www.instagram.com")

for URL in "${URLS[@]}"; do
	RESPONSE_TIME=$(curl -o /dev/null -sw '%{time_total}' $URL)
	echo "Response Time: for $URL is $RESPONSE_TIME"
done
