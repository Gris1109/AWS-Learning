#!/bin/bash

# Set up variables
FUNCTION_NAME="my-function"
BUCKET_NAME="my-bucket"
AWS_REGION="us-east-1"
IAM_ROLE="arn:aws:iam::123456789012:role/my-role"

# Create Lambda function
aws lambda create-function \
--function-name $FUNCTION_NAME \
--runtime python3.9 \
--role $IAM_ROLE \
--handler lambda_function.lambda_handler \
--zip-file fileb://my-function.zip \
--region $AWS_REGION

# Create S3 bucket
aws s3api create-bucket \
--bucket $BUCKET_NAME \
--region $AWS_REGION

# Configure S3 bucket to trigger Lambda function
aws lambda add-permission \
--function-name $FUNCTION_NAME \
--statement-id s3-invoke \
--action "lambda:InvokeFunction" \
--principal s3.amazonaws.com \
--source-arn arn:aws:s3:::$BUCKET_NAME \
--region $AWS_REGION

# set up the S3 trigger.
aws s3api put-bucket-notification-configuration \
--bucket $BUCKET_NAME \
--notification-configuration '{
    "LambdaFunctionConfigurations": [{
        "LambdaFunctionArn": "arn:aws:lambda:'$AWS_REGION':123456789012:function:'$FUNCTION_NAME'",
        "Events": ["s3:ObjectCreated:*"],
        "Filter": {
            "Key": {
                "FilterRules": [{
                    "Name": "suffix",
                    "Value": ".txt"
                }]
            }
        }
    }]
}'
