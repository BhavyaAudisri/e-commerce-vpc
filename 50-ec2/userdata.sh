#!/bin/bash
set -e

apt-get update -y

apt-get install curl -y

curl -fsSL http://get.docker.com -o get-docker.sh
sh get-docker.sh
usermod -aG docker ubuntu

apt-get install -y nodejs npm 

apt-get install awscli -y

aws configure set aws_access_key_id "${data.aws_ssm_parameter.access_key.value}"
aws configure set aws_secret_access_key "${data.aws_ssm_parameter.secret_key.value}"
aws configure set default.region "us-east-1"
aws configure set default.output "json"

aws s3 ls

GITHUB_TOKEN="${data.aws_ssm_parameter.github_token.value}"

git clone https://BhavyaAudisri:${GITHUB_TOKEN}@github.com/BhavyaAudisri/ecommerce.git

cd /ecommerce/aws-e-commerce-project-main/ecommerce-web-app-main/frontend/react-app/src

sed -i "s|YOUR_USER_POOL_ID|${data.aws_ssm_parameter.user_pool_id.value}|g" aws_config.js

sed -i "s|YOUR_USER_POOL_CLIENT_ID|${data.aws_ssm_parameter.app_client_id.value}|g" aws_config.js

cd ..

npm install

npm run build

aws s3 sync build/ s3://ecommerce-frontend-1488 --delete --exclude "images/*"