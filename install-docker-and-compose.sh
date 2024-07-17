#!/bin/bash

# Update package list
sudo apt update

# Install Docker
sudo curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh get-docker.sh >/dev/null 2>&1

# Add the user to the docker group
sudo usermod -aG docker $USER

# Refresh group membership without stopping the script
newgrp docker <<EOF
# Commands to run after the group change
echo "User added to docker group."

# Download and install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "Docker and Docker Compose successfully installed!"

# Display versions
docker --version
docker-compose --version
EOF

# Continue with any other commands outside the newgrp context if needed
