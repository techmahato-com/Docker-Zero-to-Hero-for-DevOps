#!/bin/bash

set -e

echo "🔄 Updating APT package index..."
sudo apt update -y

echo "📦 Installing prerequisites..."
sudo apt install -y ca-certificates curl gnupg lsb-release

echo "📁 Creating keyring directory for Docker..."
sudo install -m 0755 -d /etc/apt/keyrings

echo "🔑 Downloading Docker GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "🔓 Setting permissions on GPG key..."
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "🔗 Adding Docker APT repository for Ubuntu 24.04..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  noble stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "🔄 Updating APT sources with Docker repo..."
sudo apt update -y

echo "🐳 Installing Docker Engine and CLI..."
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "🚀 Starting Docker..."
sudo systemctl start docker

echo "✅ Enabling Docker on system boot..."
sudo systemctl enable docker

echo "👤 Adding user '$USER' to docker group..."
sudo usermod -aG docker $USER

echo "🔍 Docker version check:"
docker --version || echo "⚠️ You may need to log out and log back in to use Docker without sudo."

echo "🧪 Running hello-world container to verify..."
docker run hello-world || echo "✅ Docker installed. Please re-login for non-sudo access."

echo "🎉 Docker installed successfully on Ubuntu 24.04!"
