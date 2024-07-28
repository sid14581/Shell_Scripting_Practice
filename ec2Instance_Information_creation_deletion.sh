#!/bin/bash

#############################################################################################################
##
##  Author: Siddharth Reddy
##
##  Date Created: 07-27-2024
##  Date Modified: 07-27-2024
##
##  Description: Script for the creating, deleting and displaying Information of the ec2 running instance
## 
##############################################################################################################

# Creating the Instance

set -e
set -o pipefail

creating_instance(){
  echo " "
  echo "Creating Ec2 Instance........."
  
  local ami_id=$1
  local instance_name=$2
  local instance_type=$3
  local key_pair=$4
  local security_grp=$5
  local region=$6
   
  instance_id=$( aws ec2 run-instances  --image-id "$ami_id" --instance-type "$instance_type" --key-name "$key_pair" --security-group-ids "$security_grp" \
        --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance_name}]" --region "us-east-1" --query 'Instances[0].InstanceId'  --output text
    )
  
  if [[ -z $instance_id ]]; then
    echo " Instance hasn't been created "
    exit 1
  fi
	
 waiting_instance $instance_id 

 echo " "
 echo "Ec2 instance $id has created successfully"
  	
}

#--------------------------------------------------------------------------------------------------------------------------------------------------------------

waiting_instance() {
 local id=$1
 echo " "
 echo "Waiting for the instance $id to be in running state"

 while true
 do
	 instance_state=$(aws ec2 describe-instances --instance-ids "$id" --region="us-east-1" --query 'Reservations[*].Instances[*].State.Name' --output text)

	 if [[ $instance_state = "running" ]]; then 
		echo "Ec2 instance $id is in running state"
		break
	 fi

	 sleep 15
done
}


#=========================================================================================================================

# Showing the instance Information

instance_info() {
  echo " "
  echo "Instance Information....."

  local region=$1
  echo " "
  
  instance_state=$(aws ec2 describe-instances --region="$region" --filters "Name=instance-state-name,Values=running" \
	  --query 'Reservations[*].Instances[*].State.Name' --output text )

  instance_id=$(aws ec2 describe-instances --region="$region" --filters "Name=instance-state-name,Values=running"  --query 'Reservations[*].Instances[*].InstanceId' --output text )

  instance_id=$(aws ec2 describe-instances --region="$region" --filters "Name=instance-state-name,Values=running" --query 'Reservations[*].Instances[*].InstanceId' --output text )

 instance_Type=$( aws ec2 describe-instances --region="$region" --filters "Name=instance-state-name,Values=running"  --query 'Reservations[*].Instances[*].InstanceType' --output text)
  
 instance_SGP=$(aws ec2 describe-instances --region="$region" --filters "Name=instance-state-name,Values=running"  --query 'Reservations[*].Instances[*].SecurityGroups[*].GroupName' --output text)

 instance_IPA=$(aws ec2 describe-instances --region="$region" --filters "Name=instance-state-name,Values=running"  --query 'Reservations[*].Instances[*].NetworkInterfaces[*].Association.PublicIp' --output text)

 echo "Instance State -->           $instance_state"
 echo "Instance ID -->              $instance_id"
 echo "Instance Type -->            $instance_Type"
 echo "Instance Security Group -->  $instance_SGP"
 echo "Instacne IP Address -->      $instance_IPA"

 echo " " 
}

#=========================================================================================================================

# Deleting the instance

deleting_instance(){

  echo  "Deleting the ec2 instance"

  local region=$1

  instance_state=$(aws ec2 describe-instances --region="$region" --filters "Name=instance-state-name,Values=running"  --query 'Reservations[*].Instances[*].State.Name' \
	  --output text ) 
   
  instance_id=$(aws ec2 describe-instances --region="$region" --filters "Name=instance-state-name,Values=running"  --query 'Reservations[*].Instances[*].InstanceId' --output text )

  echo "$instance_state   $instance_id"

  aws ec2 terminate-instances --region "$region" --instance-ids $instance_id

}

#===========================================================================================================================

# checking aws is installed or not

checking_aws_installed(){
  if  ! command -v aws &> /dev/null; then
     echo "Awscli is not installed !!"
     return 1
  fi 
}

#==========================================================================================================================

# installing awscli
install_awscli() {

  echo " "
  echo "Inatalling the awscli...."

  curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
  
  rm -drf aws awscliv2.zip
  
 echo " "
  aws --version
  
  if [[ "${?}"  ]]; then
      echo "AWS is installed........"
  fi
 
}

#==========================================================================================================================

#  checking_aws_installed  || install_awscli

if ! checking_aws_installed; then
      install_awscli
fi

ami_id="ami-04a81a99f5ec58529"
instance_name="YoYo"
instance_type="t2.micro"
key_pair="yoyo east-1"
security_grp="sg-0a718c8e406f30f5e"
region="us-east-1"

argument=$1

if [[ $argument = "create" ]]; then
    creating_instance "$ami_id" "$instance_name" "$instance_type" "$key_pair" "$security_grp" "$region"
fi

if [[ $argument = "delete" ]]; then 
	deleting_instance "$region"
fi

if [[ $argument = "show" ]]; then                                                                                                                         
   instance_info "$region"                                                                                           
fi


