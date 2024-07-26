#!/bin/bash

############################################################################################
#
# Author: Siddahrth Reddy
#
# Date Modified: 07-24-2024
# Date Created: 07-24-2024
#
# Usage: Cloning and Deploying the App.
# Description: Cloning and Deploying the Django App. form GIT repository 
#
############################################################################################



cloning_project() {

   git clone  https://github.com/LondheShubham153/django-notes-app

   if [[ "${#}" -eq 1  ]]; then
	echo "Project didn't get cloned"	   
	exit  1
   fi
}

installing_project_requirement() {
    echo " "
    echo "Instaling the project dependencies..."
    sudo apt-get update && sudo apt-get install -y docker.io nginx docker-compose 
    sleep 10
}

project_permissions(){
  echo " "
  echo "Providing permissions"
  sudo chown $USER /var/run/docker.sock

}

deploying_project() {
  echo " "
  echo "Project Deploying"
  docker build -t yoyoyo .  &&   docker-compose up -d
}


echo "**********************************  Deployment of  the Application *****************************"


if ! cloning_project; then
	cd django-notes-app
else
	cd django-notes-app
fi

if ! installing_project_requirement; then
	echo "project dependencies didn't get installed"
	exit 1
fi


if ! project_permissions; then
        echo "permissions aren't provided "
        exit 1
fi

if ! deploying_project; then
	echo "Project Deployment failed"
	exit 1
fi

echo "********************************  Deployment done *****************************************"
