#!/bin/bash

# Update package lists
sudo apt update
sleep 2

# Install Docker
sudo curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh get-docker.sh && sudo rm get-docker.sh  # Remove the installation script
sleep 2

# Add current user to the docker group
sudo usermod -aG docker $USER && newgrp docker
sleep 2

# Verify installation
docker --version
sleep 2

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose
sleep 2

# Verify installation
docker-compose --version

echo "Docker and Docker Compose successfully installed!"