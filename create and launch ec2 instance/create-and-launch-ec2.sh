#!/bin/bash

# Replace the following variables with your own values
AMI_ID="ami-0c55b159cbfafe1f0"
INSTANCE_TYPE="t2.micro"
KEY_NAME="my-key-pair"
SECURITY_GROUP_ID="sg-1234567890abcdef0"
SUBNET_ID="subnet-1234567890abcdef0"
TAG_KEY="Name"
TAG_VALUE="My EC2 Instance"

# Create the instance and store the instance ID in a variable
INSTANCE_ID=$(aws ec2 run-instances --image-id "$AMI_ID" \
                      --count 1 \
                      --instance-type "$INSTANCE_TYPE" \
                      --key-name "$KEY_NAME" \
                      --security-group-ids "$SECURITY_GROUP_ID" \
                      --subnet-id "$SUBNET_ID" \
                      --tag-specifications 'ResourceType=instance,Tags=[{Key='"$TAG_KEY"',Value='"$TAG_VALUE"'}]' \
                      --query 'Instances[0].InstanceId' \
                      --output text)

echo "Instance created with ID: $INSTANCE_ID"

# Wait for the instance to be running
echo "Waiting for the instance to be running..."
aws ec2 wait instance-running --instance-ids "$INSTANCE_ID"

# Get the public IP address of the instance
PUBLIC_IP=$(aws ec2 describe-instances --instance-ids "$INSTANCE_ID" \
                      --query 'Reservations[0].Instances[0].PublicIpAddress' \
                      --output text)

echo "Instance launched with public IP address: $PUBLIC_IP"
