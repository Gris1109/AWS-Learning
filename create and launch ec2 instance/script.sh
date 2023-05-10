#!/bin/bash

# Set AWS region and default security group name
AWS_REGION=us-east-1
SECURITY_GROUP_NAME=my-security-group

# Define variables for the VPC configuration
VPC_CIDR="10.0.0.0/16"
SUBNET_CIDR="10.0.0.0/24"
KEY_NAME=ec2_key

# Create the VPC and store the ID in a variable
VPC_ID=$(aws ec2 create-vpc --cidr-block "$VPC_CIDR" --query 'Vpc.VpcId' --output text)
aws ec2 create-tags --resources "$VPC_ID" --tags "Key=Name,Value=my-vpc"

# Create the subnet and store the ID in a variable
SUBNET_ID=$(aws ec2 create-subnet --vpc-id "$VPC_ID" --cidr-block "$SUBNET_CIDR" --query 'Subnet.SubnetId' --output text)
aws ec2 create-tags --resources "$SUBNET_ID" --tags "Key=Name,Value=my-ipv4-only-subnet"

# Create the security group and store its ID in a variable
SECURITY_GROUP_ID=$(aws ec2 create-security-group --group-name "$SECURITY_GROUP_NAME" --description "My security group" --vpc-id "$VPC_ID" --query 'GroupId' --output text)
aws ec2 authorize-security-group-ingress --group-id "$SECURITY_GROUP_ID" --protocol tcp --port 22 --cidr 0.0.0.0/0

# Create SSH Key Pair and save the private key to a file
aws ec2 create-key-pair --key-name "$KEY_NAME" --query 'KeyMaterial' --output text > ~/.ssh/"$KEY_NAME"
chmod 400 ~/.ssh/"$KEY_NAME"

# Print out the resources created for verification
echo "VPC created with ID: $VPC_ID"
echo "Subnet created with ID: $SUBNET_ID"
echo "Security group created with ID: $SECURITY_GROUP_ID"
echo "SSH key pair created and saved to ~/.ssh/$KEY_NAME"
