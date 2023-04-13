# Docker Compose for MySQL, FreeRADIUS with Daloradius GUI, and Ocserv with Terraform on AWS
This repository contains a Docker Compose file along with a custom Dockerfile for Ocserv, which is rebuilt from the tommylau/ocserv image with changes in the authentication section of the "/etc/ocserv/ocserv.conf" file to pass authentication requests to a RADIUS server. Additionally, it includes Terraform configuration files to automate the provisioning of an instance on Amazon Web Services (AWS) cloud with the Docker Compose environment pre-configured and ready to use.


## Prerequisites
Before using this repository, ensure that you have the following software installed on your local machine:

Docker: To build and run Docker containers.


Docker Compose: To define and run multi-container Docker applications.


Terraform: To automate provisioning of AWS resources.




## Usage
You can deploy this Docker Compose environment in two ways:


**AWS Deployment with Terraform**: Follow the steps below to deploy the environment on Amazon Web Services (AWS) cloud using Terraform.

  Clone this repository to your local machine: git clone https://github.com/mbaniadam/ocserv-with-daloaradius-docker.git

  Change to the cloned directory: cd ocserv-with-daloaradius-docker/terraform

  Update the Terraform configuration files (main.tf, variables.tf, etc.) to specify your AWS access keys, region, and other settings.

  Initialize the Terraform working directory: terraform init

  Provision an AWS instance: terraform apply

  After Terraform completes provisioning the AWS instance, you can use the public IP or DNS of the instance to access the Docker Compose environment       remotely.

  On the AWS instance, run the command docker-compose up to start the containers and deploy the Ocserv server with the custom configuration for RADIUS     authentication.



**Local Deployment with Docker Compose**: Follow the steps below to deploy the environment on your local machine.

  Clone this repository to your local machine: git clone https://github.com/mbaniadam/ocserv-with-daloaradius-docker.git

  Change to the cloned directory: cd ocserv-with-daloaradius-docker

  Update the docker-compose.yml file to configure the services as per your requirements.

  You can customize settings such as database credentials, FreeRADIUS configuration, and Ocserv settings.

  Build and start the Docker containers: docker-compose up -d

  Access the Daloradius GUI in your web browser by navigating to http://localhost:80 or http://<docker-host-ip>:80.


  ***Note***: Make sure to customize the settings in the docker-compose.yml file and the Terraform configuration files (main.tf, variables.tf, etc.) according to your requirements before deploying the environment.
