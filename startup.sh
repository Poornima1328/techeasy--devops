#!/bin/bash
apt update -y
apt install -y httpd awscli
systemctl start httpd
systemctl enable httpd

echo "<h1>App is Running - $(hostname)</h1>" > /var/www/html/index.html
echo "App started at $(date)" > /tmp/app.log
aws s3 cp /tmp/app.log s3://${bucket_name}/app/logs/

