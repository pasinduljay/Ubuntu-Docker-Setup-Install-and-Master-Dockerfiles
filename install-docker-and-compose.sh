#!/bin/bash

# Define color codes
LIGHT_BLUE='\033[1;34m'
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Update package list
echo -e "${GREEN}Updating package list...${NC}"
sudo apt update

# Function to check if Docker is installed
check_docker_installed() {
    docker --version >/dev/null 2>&1
}

# Function to install Docker
install_docker() {
    echo -e "${GREEN}Installing Docker...${NC}"
    sudo curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh get-docker.sh >/dev/null 2>&1
}

# Install Docker and check until installed
while ! check_docker_installed; do
    install_docker
done

# Install Docker Compose
echo -e "${GREEN}Installing Docker Compose...${NC}"
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

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

echo -e "${GREEN}Setup completed successfully!${NC}"

# Add user to the docker group
echo -e "${GREEN}Adding user to the Docker group...${NC}"
sudo usermod -aG docker $USER

# Remove Docker installation script
sudo rm get-docker.sh

echo -e "${LIGHT_BLUE}Do you need to refresh group membership? (Recommended) (Y/n):${NC} \c"
read user_input
user_input=${user_input:-Y}

if [[ $user_input =~ ^[Yy]$ ]]; then
    echo -e "${GREEN}Refreshing group membership...${NC}"
    for i in 3 2 1; do
        echo -e "${RED}$i${NC}"
        sleep 1
    done

    newgrp docker
else
    echo -e "${RED}Group membership refresh skipped.${NC}"
fi
