#!/bin/bash
set -xe

apt-get update -y

apt-get install curl -y

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
usermod -aG docker ubuntu

apt-get install -y nodejs npm 
apt-get install -y git

apt-get install awscli -y

aws configure set aws_access_key_id "${access_key}"
aws configure set aws_secret_access_key "${secret_key}"
aws configure set default.region "us-east-1"
aws configure set default.output "json"

git clone https://BhavyaAudisri:${GITHUB_TOKEN}@github.com/BhavyaAudisri/ecommerce.git

cd /root/ecommerce/aws-e-commerce-project-main/ecommerce-web-app-main/frontend/react-app/src

sed -i "s|YOUR_USER_POOL_ID|${user_pool_id}|g" aws_config.js
sed -i "s|YOUR_USER_POOL_CLIENT_ID|${app_client_id}|g" aws_config.js

cd ..

npm install

npm run build

aws s3 ls

aws s3 sync build/ s3://ecommerce-frontend-1488 --delete --exclude "images/*"