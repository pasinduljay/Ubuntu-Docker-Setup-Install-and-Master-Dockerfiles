#!/bin/bash

# Log file path
LOG_FILE="/tmp/docker_installation.log"

# Function to log and execute commands
log_and_execute() {
    echo "[$(date)] $1" | tee -a $LOG_FILE
    eval "$1" | tee -a $LOG_FILE
}

# Update package lists
log_and_execute "sudo apt update"

# Install Docker
log_and_execute "sudo curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh get-docker.sh"
log_and_execute "sudo rm get-docker.sh"

# Add current user to the docker group
log_and_execute "sudo usermod -aG docker $USER && newgrp docker"

# Verify Docker installation
log_and_execute "docker --version"

# Install Docker Compose
log_and_execute "sudo curl -L 'https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)' -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose"

# Verify Docker Compose installation
log_and_execute "docker-compose --version"
