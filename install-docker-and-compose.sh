#!/bin/bash

# Update package list
echo -e "\033[0;32mUpdating package list...\033[0m"
sudo apt update

# Install Docker
echo -e "\033[0;32mInstalling Docker...\033[0m"
sudo curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh get-docker.sh >/dev/null 2>&1

# Install Docker Compose
echo -e "\033[0;32mInstalling Docker Compose...\033[0m"
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Define color codes
LIGHT_BLUE='\033[1;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if Docker and Docker Compose are installed
docker_version=$(docker --version 2>/dev/null)
compose_version=$(docker-compose --version 2>/dev/null)

# Print versions with color
if [ -n "$docker_version" ]; then
    echo -e "${LIGHT_BLUE}$docker_version${NC}"
else
    echo -e "${RED}Docker is not installed.${NC}"
fi

if [ -n "$compose_version" ]; then
    echo -e "${LIGHT_BLUE}$compose_version${NC}"
else
    echo -e "${RED}Docker Compose is not installed.${NC}"
fi

echo -e "\033[0;32mSetup completed successfully!\033[0m"

# Add user to the docker group
echo -e "\033[0;32mAdding user to the Docker group...\033[0m"
sleep 1
echo -e "\033[0;31m3\033[0m"
sleep 1
echo -e "\033[0;31m2\033[0m"
sleep 1
echo -e "\033[0;31m1\033[0m"

sudo usermod -aG docker $USER
sudo rm get-docker.sh
# Refresh group membership
echo -e "\033[0;32mRefreshing group membership...\033[0m"
newgrp docker







