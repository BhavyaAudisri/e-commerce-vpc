#!/bin/bash
set -xe

# Log everything
exec > >(tee /var/log/ecommerce.log)
exec 2>&1

echo "Starting ecommerce setup..."

# Update packages
echo "Installing packages..."
apt-get update -y

# Install required packages
apt-get install -y \
    curl \
    git \
    unzip
echo "Installing Node.js..."

curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -

apt-get install -y nodejs
    
cd /tmp
echo "Installing aws cli ..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip

unzip -q awscliv2.zip

./aws/install

aws --version

# Install Docker
echo "Installing Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Add ubuntu user to docker group
usermod -aG docker ubuntu

# Configure AWS CLI
echo "configuring aws ..."
aws configure set aws_access_key_id "$ACCESS_KEY"
aws configure set aws_secret_access_key "$SECRET_KEY"
aws configure set default.region "us-east-1"
aws configure set default.output "json"

# Clone repository
echo "cloning repository ..."
cd /root

if [ -d "ecommerce" ]; then
    rm -rf ecommerce
fi

git clone https://github.com/BhavyaAudisri/e-commerce.git


# Navigate to React application
cd /root/e-commerce/aws-e-commerce-project-main/ecommerce-web-app-main/frontend/react-app/src

# Update Cognito configuration
sed -i "s|YOUR_USER_POOL_ID|$USER_POOL_ID|g" aws-config.js
sed -i "s|YOUR_USER_POOL_CLIENT_ID|$APP_CLIENT_ID|g" aws-config.js

# Build application
echo " building application ..."
cd ..
rm -rf node_modules package-lock.json
npm install --save-dev eslint-plugin-jest
npm install eslint@8
npm run build

# Verify AWS authentication
aws sts get-caller-identity

# Upload build to S3
echo "uploading data to s3 ..."
aws s3 sync build/ s3://ecommerce-frontend-1488 --delete --exclude "images/*"

echo "Frontend deployment completed successfully."