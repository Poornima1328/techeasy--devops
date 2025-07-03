#!/bin/bash
apt update -y
apt install -y apache2 awscli
systemctl start apache2
systemctl enable apache2

echo "<h1>App is Running - $(hostname)</h1>" > /var/www/html/index.html
echo "App started at $(date)" > /tmp/app.log
aws s3 cp /tmp/app.log s3://${bucket_name}/app/logs/
