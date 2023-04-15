In this script.sh file, we've defined a few variables to make it easy to modify the script as needed. 
You can adjust these variables as needed to match your specific use case.
The script starts by creating a new Lambda function using the aws lambda create-function command. 
It then creates a new S3 bucket using the aws s3api create-bucket command.
Next, the script configures the S3 bucket to trigger the Lambda function whenever a new object is added to the bucket. 
This is done using the aws lambda add-permission command to give S3 permission to invoke the Lambda function, 
and the aws s3api put-bucket-notification-configuration command to set up the S3 trigger.

Note that in the aws s3api put-bucket-notification-configuration command, 
we're using string interpolation to substitute the values of the $FUNCTION_NAME and $AWS_REGION variables into the ARN for the Lambda function. 
This ensures that the correct ARN is used for the Lambda function, even if you change the value of $FUNCTION_NAME or $AWS_REGION.
