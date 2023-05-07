#!/bin/bash

# Set your AWS region, bucket name, and file path
region="us-east-1"
bucket_name="my-bucket-name"
file_path="/path/to/my/file.txt"

# Upload the file to the bucket using the AWS CLI
aws s3 cp $file_path s3://$bucket_name/

echo "File uploaded to S3 bucket: $bucket_name"
