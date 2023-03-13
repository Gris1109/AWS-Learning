creates an S3 bucket, uploads a CloudFormation template to it, and creates a new CloudFormation stack from the template

the --template-url parameter must point to the URL of the uploaded template file in the S3 bucket.

This script uses the aws s3 presign command to get a pre-signed URL for the uploaded template file in the S3 bucket, 
which is then used as the --template-url parameter when creating the CloudFormation stack. 
This ensures that the URL is accessible and authorized to be accessed by the CloudFormation service.
