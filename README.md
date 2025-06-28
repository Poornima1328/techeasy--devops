 Multi-Stage AWS Deployment with Terraform & GitHub Integration

 main.tf # Terraform config for EC2 & supporting infra
 user_data.sh # Bootstrap script for EC2
outputs.tf # Public IP & instance ID outputs
variables.tf # Input variable definitions

 dev.tfvars # Variables for dev stage
 prod.tfvars # Variables for prod stage
 
 dev.json # Public configuration file (for dev)
 prod.json # Private configuration file (for prod)

1️⃣ Parameterized Multi-Stage Deployment

- Supports `dev`, `qa`, and `prod` stages.
- Select environment via variable file:

  terraform apply -var-file="env/dev.tfvars"
  terraform apply -var-file = "env/prod.tfvars"

2️⃣ Config Separation per Stage
Separate runtime config files for each stage:

dev.json for development

prod.json for production

Automatically downloaded into EC2 as /app/config.json via user_data.sh.

3️⃣ Public/Private GitHub Config Strategy
Configs are fetched using:

curl -H "Authorization: token ${github_token}" -L \
https://raw.githubusercontent.com/<user>/<repo>/main/configs/${env_name}.json \
-o /app/config.json

dev for public repo
prod for private repo

4️⃣ Secure GitHub Token Handling
Use a GitHub Personal Access Token (PAT) for private repo access.

5. Stage-Based S3 Log Upload
After EC2 setup, app logs are written to /var/log/app.log

Automatically pushed to S3 folder:
s3://your-bucket-name/logs/dev/app.log
s3://your-bucket-name/logs/prod/app.log

6️⃣ Post-Deployment Health Check
Use curl or browser to verify instance health:

curl http://<instance_public_ip>
Expected output:
<h1>dev deployment successful</h1>

Cleanup
To destroy infrastructure:

terraform destroy -var-file="env/dev.tfvars"


  
