AWS EC2 and S3 Infrastructure Provisioning using Terraform This project automates the provisioning of an EC2 instance and an S3 bucket using Terraform on Ubuntu 22.04.

🔧 Prerequisites Ubuntu 22.04 machine (or EC2/DigitalOcean instance)

AWS account and IAM user with appropriate permissions

Pre-created Key Pair in your AWS region

Terraform installed

AWS CLI installed

🧱 Install Terraform on Ubuntu 22.04 AWS EC2 and S3 Infrastructure Provisioning using Terraform

This project automates the provisioning of an EC2 instance and an S3 bucket using Terraform on Ubuntu 22.04.
sudo su -

apt update

apt install -y gnupg software-properties-common curl

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

sudo apt-get update && sudo apt-get install terraform

terraform -v

 Directory and File Setup

mkdir newdirectory

cd newdirectory

Create the following files with appropriate Terraform code:

main.tf, ec2.tf, s3.tf, iam.tf, variables.tf, outputs.tf, startup.sh, setup.sh

deploy.yaml, dev.json, dev.tfvars, prod.json, prod.tfvars, user_data.sh, cloudwatch-config.json

Edit these files using your preferred editor (e.g., vi, nano, vscode).

🛠️ AWS CLI Configuration

Install and configure the AWS CLI:

sudo apt install awscli

aws configure

Provide:

Access Key ID

Secret Access Key

Default region (e.g., us-east-1)

Output format (e.g., json)

🚀 Terraform Workflow

Initialize Terraform:

terraform init

Run a plan to preview the infrastructure:

terraform plan

Provide Input When Prompted:

Your email for SNS alerts

AMI to use for EC2
AWS Region (for example Enter a value: us-east-2)
S3 Bucket Name (must be globally unique)
Environment name (e.g., dev or prod) (for example Enter a value: dev)
EC2 instance type (for example Enter a value: t2.micro)
Key Pair Name (already created in AWS) (for example Enter a value: newkeypair)

Apply the infrastructure:
terraform apply
Type yes to confirm and provision the infrastructure.
next run this command (This command removes the resource from Terraform state without touching the actual infrastructure.)

Test Upload to S3 (Step-by-Step)

✅ 1. Create a Test File

echo "Good Morning!" > file.txt

✅ 2. Upload the File to Your S3 Bucket

Replace with your actual bucket name:

aws s3 cp file.txt s3://bucket_name/


✅ 3. Verify the Upload

aws s3 ls s3://bucket_name/

You should see file.txt in the output.

✅ 4. (Optional) Download the File Back

To confirm the upload:

aws s3 cp s3://bucket_name/file.txt downloaded.txt

cat downloaded.txt

You should see:
Good Morning!


Health Check

curl de-instance_public-ip


dev deployment successful This confirms:
Your application is up and running on port 80

The EC2 instance (dev-instance with public ip  ) is reachable publicly
Your deployment succeeded and the health check passes



