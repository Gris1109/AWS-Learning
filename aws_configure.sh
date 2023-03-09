#!/bin/bash

echo "AWS Configuration Script"

read -p "Enter your AWS Access Key ID: " AWS_ACCESS_KEY_ID
read -p "Enter your AWS Secret Access Key: " AWS_SECRET_ACCESS_KEY
read -p "Enter your default AWS Region: " AWS_DEFAULT_REGION
read -p "Enter your preferred output format (json or text): " AWS_OUTPUT_FORMAT

aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure set default.region $AWS_DEFAULT_REGION
aws configure set default.output $AWS_OUTPUT_FORMAT

echo "AWS Configuration Completed!"
