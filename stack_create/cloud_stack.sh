#!/bin/bash

# Replace with your own values
BUCKET_NAME="your-bucket-name"
BUCKET_REGION="your-bucket-region"
TEMPLATE_FILE="your-template.yaml"
STACK_NAME="your-stack-name"

# Create S3 bucket
aws s3api create-bucket --bucket $BUCKET_NAME --region $BUCKET_REGION --create-bucket-configuration LocationConstraint=$BUCKET_REGION

# Upload CloudFormation template to S3 bucket
aws s3 cp $TEMPLATE_FILE s3://$BUCKET_NAME/

# Get the S3 object URL for the template file
TEMPLATE_URL=$(aws s3 presign s3://$BUCKET_NAME/$TEMPLATE_FILE)

# Create CloudFormation stack from template in S3 bucket
aws cloudformation create-stack --stack-name $STACK_NAME --template-url $TEMPLATE_URL
