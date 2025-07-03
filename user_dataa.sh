#!/bin/bash
# Install dependencies
sudo apt update -y
sudo apt install -y awscli
sudo apt install -y git jq


# Create log file
touch /home/ubuntu/app.log
chown ubuntu:ubuntu /home/ubuntu/app.log

# Install CloudWatch Agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
dpkg -i -E ./amazon-cloudwatch-agent.deb


# Fetch config from GitHub
curl -H "Authorization: token ${github_token}" -L \
"https://github.com/Poornima1328/techeasy--devops/dev.json" \
-o /app/config.json

curl -H "Authorization: token ${github_token}" -L \
"https://github.com/Poornima1328/config-repo-private/prod.json" \
-o /app/config.json

# Start dummy app
echo "Starting web server..."
sudo apt install -y apache2
systemctl start apache2
echo "<h1>${env_name} deployment successful</h1>" > /var/www/html/index.html

# Fetch CloudWatch Agent config from public GitHub
curl -L \
"https://raw.githubusercontent.com/Chandan-Tippari-KK/tech-easy-DevOps-Chandan-Tippari/main/cloudwatch-config.json" \
-o /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

# Start the agent
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config \
  -m ec2 \
  -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json \
  -s
