#!/bin/bash

set -e

echo "🔄 Updating package index..."
sudo dnf update -y

echo "📦 Installing Docker Engine..."
sudo dnf install docker -y

echo "✅ Starting Docker service..."
sudo systemctl start docker

echo "🟢 Enabling Docker to start on boot..."
sudo systemctl enable docker

echo "👤 Adding current user to docker group..."
sudo usermod -aG docker "$USER"

echo "🔍 Verifying Docker version..."
docker --version || echo "Please log out and log back in for docker group to take effect."

echo "🚀 Running hello-world container test..."
docker run hello-world || echo "You may need to re-login to use Docker without sudo."

echo "✅ Docker installation completed successfully!"
