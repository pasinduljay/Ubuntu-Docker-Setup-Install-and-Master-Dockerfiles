#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status
set -x  # Print each command before executing it for better debugging

# Update package lists
sudo apt update

# Install Docker
sudo apt-get install -y docker.io

# Add current user to the docker group
sudo usermod -aG docker $USER && newgrp docker

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose 
sudo chmod +x /usr/local/bin/docker-compose

# Verify installation
docker --version
docker-compose --version

echo "Docker and Docker Compose successfully installed!"
