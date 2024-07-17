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

# Check if Docker and Docker Compose are installed
docker_version=$(docker --version 2>/dev/null)
compose_version=$(docker-compose --version 2>/dev/null)

# Display versions
if [ -n "$docker_version" ] && [ -n "$compose_version" ]; then
    echo -e "\033[0;32mDocker installed successfully:\033[0m $docker_version"
    echo -e "\033[0;32mDocker Compose installed successfully:\033[0m $compose_version"
else
    if [ -z "$docker_version" ]; then
		echo -e "\033[0;31mDocker is not installed.\033[0m"
    fi
    if [ -z "$compose_version" ]; then
		echo -e "\033[0;31mDocker Compose is not installed.\033[0m"
    fi
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

# Refresh group membership
echo -e "\033[0;32mRefreshing group membership...\033[0m"
newgrp docker







