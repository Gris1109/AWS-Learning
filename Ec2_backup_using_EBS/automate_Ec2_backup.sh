#!/bin/bash

# Set the region where your EC2 instance is located
export AWS_DEFAULT_REGION=us-east-1

# Set the instance ID
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

# Get the list of EBS volumes attached to the instance
VOLUMES=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[].Instances[].BlockDeviceMappings[].Ebs[].VolumeId" --output text)

# Loop through each volume and create a snapshot
for VOLUME in $VOLUMES; do
    aws ec2 create-snapshot --volume-id $VOLUME --description "Automated backup of volume $VOLUME on instance $INSTANCE_ID"
done

# You can add a cron job to run at the end of the script
# 0 0 * * * /path/to/backup-script.sh
