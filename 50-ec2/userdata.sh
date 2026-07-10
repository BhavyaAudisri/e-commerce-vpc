#!/bin/bash
set -xe

# Log everything
exec > >(tee /var/log/ecommerce.log)
exec 2>&1

echo "Starting ecommerce setup..."

# Update packages
apt-get update -y

# Install required packages
apt-get install -y \
    curl \
    git \
    npm \
    unzip \

curl -fsSL https://deb.nodesource.com/setup_22.x | bash -

apt-get install -y nodejs
    
cd /tmp

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip

unzip -q awscliv2.zip

./aws/install

aws --version

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Add ubuntu user to docker group
usermod -aG docker ubuntu

# Configure AWS CLI
aws configure set aws_access_key_id "$ACCESS_KEY"
aws configure set aws_secret_access_key "$SECRET_KEY"
aws configure set default.region "us-east-1"
aws configure set default.output "json"

# Clone repository
cd /root

if [ -d "ecommerce" ]; then
    rm -rf ecommerce
fi

git clone https://BhavyaAudisri:$GITHUB_TOKEN@github.com/BhavyaAudisri/e-commerce.git


# Navigate to React application
cd /root/e-commerce/aws-e-commerce-project-main/ecommerce-web-app-main/frontend/react-app/src

# Update Cognito configuration
sed -i "s|YOUR_USER_POOL_ID|$USER_POOL_ID|g" aws-config.js
sed -i "s|YOUR_USER_POOL_CLIENT_ID|$APP_CLIENT_ID|g" aws-config.js

# Build application
cd ..

npm install
npm run build

# Verify AWS authentication
aws sts get-caller-identity

# Upload build to S3
aws s3 sync build/ s3://ecommerce-frontend-1488 --delete --exclude "images/*"

echo "Frontend deployment completed successfully."