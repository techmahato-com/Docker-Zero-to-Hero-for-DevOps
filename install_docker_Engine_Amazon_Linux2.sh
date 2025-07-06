#!/bin/bash

# Exit on error
set -e

echo "🔄 Updating system packages..."
sudo yum update -y

echo "📦 Installing required packages..."
sudo yum install -y yum-utils

echo "🔗 Adding Docker repository..."
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

echo "📥 Installing Docker Engine..."
sudo yum install -y docker-ce docker-ce-cli containerd.io

echo "🚀 Starting Docker service..."
sudo systemctl start docker

echo "✅ Enabling Docker to start on boot..."
sudo systemctl enable docker

echo "👤 Adding current user ($USER) to docker group..."
sudo usermod -aG docker $USER

echo "🔍 Checking Docker version..."
docker --version || echo "⚠️ Please log out and log in again to use Docker without sudo."

echo "🧪 Running hello-world container to verify..."
docker run hello-world || echo "✅ Docker is installed. Re-login may be required to run Docker without sudo."

echo "🎉 Docker installation completed successfully on Amazon Linux 2!"
