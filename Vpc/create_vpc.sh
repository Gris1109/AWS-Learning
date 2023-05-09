#!/bin/bash

# Define variables for the VPC configuration
VPC_CIDR="10.0.0.0/16"
VPC_NAME="my-vpc"

# Create the VPC and store the ID in a variable
VPC_ID=$(aws ec2 create-vpc --cidr-block $VPC_CIDR --output text --query 'Vpc.VpcId')

# Add a name tag to the VPC
aws ec2 create-tags --resources $VPC_ID --tags "Key=Name,Value=$VPC_NAME"

# Output the VPC ID to the console
echo "Created VPC with ID: $VPC_ID"




### note this script creates a vpc and a default security group attached to the vpc
### if the vpc is deleted the security group attached/associated with this vpc is also deleted
