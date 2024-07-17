#!/bin/bash

sudo apt update

sudo apt-get install -y docker.io

sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose 
sudo chmod +x /usr/local/bin/docker-compose

docker --version
docker-compose --version

echo "Docker and Docker Compose successfully installed!"

echo "Additinally add user to the docker group" 

sudo usermod -aG docker $USER && newgrp docker