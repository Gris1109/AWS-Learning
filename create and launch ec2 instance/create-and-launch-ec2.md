This script first sets the necessary parameters for the EC2 instance, including the AMI ID, instance type, key pair, security group ID, and subnet ID. It also adds a tag to the instance with a key of Name and a value of My EC2 Instance.

The script then creates the instance using the aws ec2 run-instances command and stores the instance ID in a variable. It also waits for the instance to be in the running state using the aws ec2 wait instance-running command.

Finally, the script retrieves the public IP address of the instance using the aws ec2 describe-instances command and outputs it to the console.

Note that you should replace the placeholder values with your own values for the script to work correctly. the script to file as create-and-launch-ec2.sh, make it executable using the chmod +x create-and-launch-ec2.sh command, and then run it using ./create-and-launch-ec2.sh.
