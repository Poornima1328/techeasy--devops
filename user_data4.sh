# Install dependencies
sudo apt update -y
sudo apt install -y awscli
sudo apt install -y git jq


# Fetch config file from GitHub
curl -H "Authorization: token ${github_token}" -L \
"https://github.com/Poornima1328/techeasy--devops/dev.json" \
-o /app/config.json
 
curl -H "Authorization: token ${github_token}" -L \
"https://github.com/Poornima1328/config_repo_private/prod.json" \
  -o /app/config.json



# Start dummy app
echo "Starting web server..."
sudo apt install -y apache2
systemctl start apache2
echo "<h1>${env_name} deployment successful</h1>" > /var/www/html/index.html
