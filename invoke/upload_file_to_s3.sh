#!/bin/bash

# Set the AWS region
region="us-east-1"

# Set the name of the S3 bucket to create
bucket_name="your-bucket-name"

# Set the name of the file to upload
file_name="your-file-name"

# Create the S3 bucket
aws s3api create-bucket --bucket $bucket_name --region $region

# Upload the file to the bucket
aws s3 cp $file_name s3://$bucket_name/

echo "File uploaded to S3 bucket successfully!"
