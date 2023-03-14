import os
import requests

# Set the region where your EC2 instance is located
os.environ['AWS_DEFAULT_REGION'] = 'us-east-1'

# Set the instance ID
INSTANCE_ID = requests.get('http://169.254.169.254/latest/meta-data/instance-id').text

# Get the list of EBS volumes attached to the instance
VOLUMES = os.popen(f"aws ec2 describe-instances --instance-ids {INSTANCE_ID} --query \"Reservations[].Instances[].BlockDeviceMappings[].Ebs[].VolumeId\" --output text").read().split()

# Loop through each volume and create a snapshot
for VOLUME in VOLUMES:
    os.system(f"aws ec2 create-snapshot --volume-id {VOLUME} --description \"Automated backup of volume {VOLUME} on instance {INSTANCE_ID}\" --tag-specifications 'ResourceType=snapshot,Tags=[{{Key=RetentionPeriod,Value=7}}]'")

# You can add a cron job to run at the end of the script
# 0 0 * * * /path/to/backup-script.sh


"""
Note: This script uses os.popen() to execute the AWS CLI command to get the list of volumes and os.system() to execute the command to create a snapshot for each volume.
"""

"""
os.popen() is a Python method that is used to execute shell commands from within a Python program and return the output of the command as a file-like object.
It creates a pipe to the command that is being executed, and the output of the command can be read from the file-like object. It can be used to execute any command that can be run from the command line, such as system commands or other shell scripts.
For example, in the previous script, os.popen() was used to execute the aws ec2 describe-instances command and retrieve the list of EBS volumes attached to the instance. The output of the command was read as a string using the .read() method and then split into a list of strings using the .split() method.
However, note that os.popen() is a legacy method that has been replaced by the subprocess module, which provides more powerful and secure ways to execute shell commands. It's recommended to use subprocess instead of os.popen() for new code.
"""
