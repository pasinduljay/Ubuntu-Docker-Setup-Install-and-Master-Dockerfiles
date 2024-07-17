#!/bin/bash

# Update package lists
sudo apt update

# Install Docker
sudo apt-get install docker.io

# Add current user to the docker group
sudo usermod -aG docker $USER && newgrp docker


# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose

# Verify installation
docker --version
docker-compose --version

echo "Docker and Docker Compose successfully installed!"
