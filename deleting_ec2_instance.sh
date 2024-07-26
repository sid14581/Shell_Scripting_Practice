#!/bin/bash

state=$(aws ec2 describe-instances  --region "us-east-1" --query 'Reservations[*].Instances[*].[State.Name][0]' --output text)
instance_id=$(aws ec2 describe-instances  --region "us-east-1" --query 'Reservations[*].Instances[*].InstanceId' --output text)

if [[ $state = "running"  ]]; then 
  echo "Deleting the EC2-instance $instance_id...."

  aws ec2 terminate-instances  --region "us-east-1" --instance-id $instance_id
fi



