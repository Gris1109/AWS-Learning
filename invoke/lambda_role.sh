#!/bin/bash

# Define the name of the execution role
EXECUTION_ROLE_NAME="MyExecutionRole"

# Create the execution role
aws iam create-role --role-name $EXECUTION_ROLE_NAME \
--assume-role-policy-document file://assume-role-policy.json

# Attach the S3 access policy to the execution role
aws iam attach-role-policy --role-name $EXECUTION_ROLE_NAME \
--policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess
