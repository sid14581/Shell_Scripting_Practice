#!/bin/bash

#################################################################################
# 
# Author: Siddharth Reddy
#
# Date Created: 07-21-2024
# Date Modified: 07-21-2024
#
# Usage: Listing User Access
# Description: Listing all the users having access to the repository so that unnecessary users will get removed.
#
#################################################################################


arg="${#}"

helper() {
  echo "Enter one argument that is Repository name"
  exit 1
}

if [[ "$arg" -ne 1 ]]; then
   helper
fi


USERNAME=$username
TOKEN=$token

REPO_ORG=$1

repos=($(curl -s -u $USERNAME:$TOKEN  https://api.github.com/orgs/$REPO_ORG/repos | jq -r '.[] | .full_name'))
echo " "
echo ${repos[@]}

for repo in "${repos[@]}"; do
  users=$(curl -s -u $USERNAME:$TOKEN  "https://api.github.com/repos/${repo}/collaborators" | jq -r '.[] |  .login' )
	 # | select(.permissions.admin==true) 

  if [[ -z "$users" ]]; then
    echo " "      
    echo "Users doesn't have the access to the ${repo}"
  else
    echo " "
    echo "Users have access to the ${repo}"
    echo "${users}"
  fi
done


