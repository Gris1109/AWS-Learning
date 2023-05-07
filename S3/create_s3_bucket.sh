#!/bin/bash

# Set your AWS region and bucket name
region="us-east-1"
bucket_name="my-bucket-name"

# Create the bucket using the AWS CLI
aws s3api create-bucket --bucket $bucket_name --region $region

echo "Bucket created: $bucket_name"
