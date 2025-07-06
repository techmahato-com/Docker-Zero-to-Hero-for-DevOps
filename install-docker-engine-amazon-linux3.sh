#!/bin/bash

# Exit on error
set -e

echo "🔄 Updating packages..."
sudo dnf update -y

echo "📦 Installing Docker..."
sudo dnf install -y docker

echo "🚀 Starting Docker service..."
sudo systemctl start docker

echo "✅ Enabling Docker on system boot..."
sudo systemctl enable docker

echo "👤 Adding current user ($USER) to docker group..."
sudo usermod -aG docker $USER

echo "🔍 Docker version installed:"
docker --version || echo "⚠️ Docker installed, but might need re-login to use without sudo."

echo "🧪 Running test container (hello-world)..."
docker run hello-world || echo "✅ Docker is installed, but logout/login may be needed to run containers without sudo."

echo "🎉 Docker installation on Amazon Linux 3 completed!"
