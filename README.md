# Deploying OCSERV, MySQL, FreeRadius, and Daloradius on AWS using Terraform and Docker Compose
![download](https://user-images.githubusercontent.com/75830370/232514972-4f7c3f39-6889-4068-ba38-d8a886c1a87f.png)


This repository contains Terraform code to deploy an instance on Amazon Web Services (AWS) and then use Docker Compose to deploy OCSERV (OpenConnect VPN server), MySQL, FreeRadius, and Daloradius containers on the instance.




## Prerequisites
Before you begin, make sure you have the following:

AWS account with necessary permissions to create EC2 instances, VPCs, and security groups

- Terraform installed on your local machine

- AWS CLI installed on your local machine and configured with your AWS credentials


## Deployment Steps
1- Clone this repository to your local machine.

2- Navigate to the terraform directory in the repository.

3- Update the variables.tfvars file with your desired values for the following variables:

  - aws_region: The AWS region where you want to deploy the resources (e.g., us-west-2).

  - aws_access_key: Your AWS access key.
  - aws_secret_access_key: Your AWS secret access key.
  - instance_type: The EC2 instance type for the VPN server (e.g., t2.micro).
  - key_name: The name of your EC2 key pair for SSH access.
  
    https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html

4- Initialize the Terraform working directory by running terraform init.

5- Provision the AWS resources by running **terraform apply**. Confirm the changes when prompted.

6- Once the AWS resources are created, you will see the public IP address of the instance in the Terraform output. Make note of this IP address.

7- Once the containers are up and running, you can access the Daloradius webGUI by navigating to ht<SPAN>tp://<public_ip_address> in your web browser.

8- Create a user for openconnect service.

9- You can now use OpenConnect VPN server with authentication against the FreeRadius server.


## Clean Up


To clean up the AWS resources created by Terraform, you can run terraform destroy in the terraform directory.


**Note**: This will destroy all the resources created by Terraform, including the EC2 instance, VPC, and security groups.

Make sure to backup any data you want to keep before running this command.


## Contributions
Contributions to this project are welcome! Please open an issue or submit a pull request with any changes or improvements you would like to contribute.



