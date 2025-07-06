#!/bin/bash

set -e

echo "🔄 Updating APT package index..."
sudo apt update -y

echo "📦 Installing prerequisites..."
sudo apt install -y ca-certificates curl gnupg lsb-release

echo "📁 Creating keyrings directory..."
sudo install -m 0755 -d /etc/apt/keyrings

echo "🔑 Downloading Docker GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "🔓 Setting permissions for keyring..."
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "🔗 Adding Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "🔄 Updating APT package index again..."
sudo apt update -y

echo "🐳 Installing Docker Engine..."
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "🚀 Starting Docker service..."
sudo systemctl start docker

echo "✅ Enabling Docker to start at boot..."
sudo systemctl enable docker

echo "👤 Adding current user ($USER) to docker group..."
sudo usermod -aG docker "$USER"

echo "🔍 Docker version:"
docker --version || echo "⚠️ You may need to re-login to use Docker without sudo."

echo "🧪 Running hello-world test container..."
docker run hello-world || echo "✅ Docker installed. Re-login may be required."

echo "🎉 Docker installation on Ubuntu 22.04 completed!"
