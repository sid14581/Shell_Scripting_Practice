#!/bin/bash

set -u 
set -e
set -o pipefail

checking_aws_exist() {
  if ! command -v aws &> /dev/null ; then 
	  echo "Install the AWS." >&2
	  return 1
  fi
}

installing_aws() {
  echo " "
  echo "Instaling the AWS CLI"

  cd /home/ubuntu/

  curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" 
 
  sudo apt-get install -y unzip &> /dev/null
 
  unzip -q awscliv2.zip 

  sudo ./aws/install 
  echo " "

  aws --version
  echo " "

  rm -drf awscliv2.zip ./aws
  echo " "
  echo "AWSCLI is installed"

  cd /home/ubuntu/Shell_Scripting_practice/
}


creating_ec2_instance() {
  local instance_name=$1
  local ami_id=$2
  local instance_type=$3
  local key_name=$4
  local subnet_id=$5
  local security_grp=$6

  instance_id=$(
    aws ec2 run-instances --image-id "$ami_id" --instance-type "$instance_type" --key-name "$key_name" --subnet-id "$subnet_id" --security-group-ids "$security_grp"     --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance_name}]" --query 'Instances[0].InstanceId' --output text  )

 if [[ -z "$instance_id" ]]; then
    echo "Failed to create Ec2 instance"
    exit 1
 fi

 echo "Instance $instance_id created successfully."

 wait_instance "$instance_id"

}


waiting_instance() {
  
}



#checking_aws_exist || installing_aws

if ! checking_aws_exist; then 
       	installing_aws
fi

Instance_Name="Ec2_via_Shell_Script"
AMI_ID=""
Instance_Type="t2.micro"
Key_Name=""
Subnet_Id=""
Security_Grp=""

creating_ec2_instance 


