#!/bin/bash

# Set the name of the EC2 instance
INSTANCE_NAME=my-ec2-instance

# Launch the EC2 instance and store the instance ID in a variable
INSTANCE_ID=$(aws ec2 run-instances \
  --image-id ami-123456789 \
  --instance-type t2.micro \
  --key-name $KEY_NAME \
  --security-group-ids $SECURITY_GROUP_ID \
  --subnet-id $SUBNET_ID \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value='$INSTANCE_NAME'}]' \
  --output text \
  --query 'Instances[0].InstanceId')

# Output the instance ID to the console
echo "Created EC2 instance with ID: $INSTANCE_ID"

# Wait for the instance to be in a running state
aws ec2 wait instance-running --instance-ids $INSTANCE_ID

# Retrieve the public IP address of the instance
PUBLIC_IP=$(aws ec2 describe-instances \
  --instance-ids $INSTANCE_ID \
  --output text \
  --query 'Reservations[0].Instances[0].PublicIpAddress')

# Output the public IP address to the console
echo "Instance public IP address: $PUBLIC_IP"

# SSH into the instance using the key pair
ssh -i ~/.ssh/$KEY_NAME $INSTANCE_NAME@$PUBLIC_IP
