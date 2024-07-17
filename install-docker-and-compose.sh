#!/bin/bash

# Function to detect Ubuntu version
get_ubuntu_version() {
    lsb_release -cs
}

# Remove existing Docker related packages
packages=("docker.io" "docker-doc" "docker-compose" "docker-compose-v2" "podman-docker" "containerd" "runc")
for pkg in "${packages[@]}"; do
    sudo apt-get remove -y $pkg
done

# Install prerequisites
sudo apt-get update
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker's official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker-archive-keyring.gpg

# Add Docker repository to Apt sources
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(get_ubuntu_version) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Check the exit status of adding Docker's GPG key and repository
if [ $? -eq 0 ]; then
    # Install Docker packages if repository setup was successful
    sudo apt-get update
    sudo apt-get install -y \
        docker-ce \
        docker-ce-cli \
        containerd.io \
        docker-buildx-plugin \
        docker-compose

    # Add current user to docker group
    sudo usermod -aG docker $USER
    sudo chown root:docker /var/run/docker.sock

    # Display completion message
    echo "Docker installation completed successfully."
else
    echo "Failed to add Docker repository. Docker installation aborted."
fi
