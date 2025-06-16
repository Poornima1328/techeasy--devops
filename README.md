Launch one EC2 instance with configurations like AMI, instance type, keypair, security group etc and connect it to the CLI

sudo su -

search install terraform on ubuntu 22.04 digital ocean in browser

https://docs.digitalocean.com/reference/terraform/getting-started/

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

sudo apt-get update && sudo apt-get install terraform

terraform -v

mkdir repository

cd repository

ls

created files and added the code using the vi editor to different files respectively as per the requirement
Files which I have created are 

main.tf – Provider and environment setup

ec2.tf – EC2 instance definition

s3.tf – S3 bucket configuration

variables.tf – Variable declarations

outputs.tf – Output values (e.g., public IP)

iam.tf – IAM roles or user configuration

startup.sh – EC2 instance startup script

setup.sh – Additional shell script (if needed)

deploy.yaml – Optional deployment config (if applicable)

Next executed the terraform commands like

terraform init
terraform plan

prompted to enter values for:

A unique S3 bucket name

An existing EC2 key pair name in the selected region

The environment (e.g., dev or prod)

aws configure
apt install awscli

Input the following when prompted:

AWS Access Key ID

AWS Secret Access Key

AWS Region (e.g., ap-northeast-1)

Output format (e.g., json)

Ensure the access/secret keys are tied to an IAM user with the necessary permissions.

terraform apply

Re-enter the values:

S3 bucket name
Key pair name
Environment name

Then type yes to confirm

It will create the S3 bucket and EC2 instance in the specified region which we have provide in the code.
