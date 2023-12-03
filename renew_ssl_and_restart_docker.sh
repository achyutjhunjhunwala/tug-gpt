#!/bin/bash

# Navigate to the specified folder
cd /home/ec2-user/openai

# Stop the current Docker containers
docker-compose down

# Renew the SSL certificate
certbot renew

# If certbot renew was successful, start the Docker containers
if [ $? -eq 0 ]; then
    docker-compose up -d
else
    echo "Certbot renewal failed"
    exit 1
fi
