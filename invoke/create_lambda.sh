#!/bin/bash

# Set variables for function name and code file
FUNCTION_NAME="my-function"
CODE_FILE="lambda_function.zip"

# Create ZIP file containing function code
zip $CODE_FILE lambda_function.py

# Create the Lambda function
aws lambda create-function \
    --function-name $FUNCTION_NAME \
    --runtime python3.9 \
    --role arn:aws:iam::123456789012:role/lambda-role \
    --handler lambda_function.handler \
    --zip-file fileb://$CODE_FILE
