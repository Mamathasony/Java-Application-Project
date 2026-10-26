#!/bin/bash
set -eux

export DEBIAN_FRONTEND=noninteractive

apt-get update -y
apt-get install -y docker.io curl wget unzip git ca-certificates gnupg

# Start Docker
systemctl enable docker
systemctl start docker

# Install Terraform
wget -O /tmp/terraform.zip \
  https://releases.hashicorp.com/terraform/1.13.5/terraform_1.13.5_linux_amd64.zip

unzip -o /tmp/terraform.zip -d /usr/local/bin/
terraform -version

# Install Trivy
wget -O /tmp/trivy.deb \
  https://github.com/aquasecurity/trivy/releases/download/v0.67.2/trivy_0.67.2_Linux-64bit.deb

apt-get install -y /tmp/trivy.deb
trivy --version

# Verify Docker
docker --version

echo "Terraform, Docker and Trivy installation completed"