#!/bin/bash
set -e

apt update -y

curl -fsSL http://get.docker.com -o get-docker.sh
sh get-docker.sh

systemctl enable docker
systemctl start docker

usermod -aG docker ubuntu

apt-get install -y nodejs npm

apt install awscli -y