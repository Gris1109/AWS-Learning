#!/bin/bash

# exec this vpc script
. ./vpc.sh

# Set your AWS region and default security group name
AWS_REGION=us-east-1
SECURITY_GROUP_NAME=my-security-group

# Create the security group and store its ID in a variable
SECURITY_GROUP_ID=$(aws ec2 create-security-group --group-name $SECURITY_GROUP_NAME --description "My security group" --vpc-id $VPC_ID --region $AWS_REGION --output te>

# Add any inbound rules you want to the security group
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 22 --cidr 0.0.0.0/0 --region $AWS_REGION

# Print out the security group ID for verification
echo "Security group created with ID: $SECURITY_GROUP_ID"




### note the vpc id $VPC_ID used to create this security group is imported from the vpc.sh script
### the security group created from this script using vcp_id from create_vpc script is an independent SECURITY GROUP and not attached to the creation of the vpc by defualt
