#!/bin/bash

# Define variables
APP_DIR="/var/www/AutomatedPipelineProject"
CONFIG_DIR="/etc/nginx/sites-available"
LINK_DIR="/etc/nginx/sites-enabled"
CONFIG_FILE="default.conf"

echo "=== Starting Deployment ==="

# Step 1: Check and install Nginx
if ! command -v nginx &> /dev/null; then
    echo "Nginx is not installed. Installing Nginx..."
    sudo apt update && sudo apt install -y nginx
    echo "Nginx installation complete."
else
    echo "Nginx is already installed."
fi

# Step 2: Check and install Python dependencies
echo "Checking and installing Python dependencies..."
if ! python3 -m pip &> /dev/null; then
    echo "pip is not installed. Installing pip..."
    sudo apt update && sudo apt install -y python3-pip
fi

# Install Flask and other dependencies from requirements.txt
if [ -f "../app/requirements.txt" ]; then
    pip3 install --user -r ../app/requirements.txt
    echo "Python dependencies installed."
else
    echo "Error: requirements.txt not found. Please ensure it exists in the app directory."
    exit 1
fi

# Step 3: Copy application files
echo "Copying application files to $APP_DIR..."
sudo mkdir -p "$APP_DIR"
sudo cp -R ../app/* "$APP_DIR"

# Step 4: Configure Nginx
echo "Configuring Nginx..."
sudo cp "./webserver_config/$CONFIG_FILE" "$CONFIG_DIR/$CONFIG_FILE"
sudo ln -sf "$CONFIG_DIR/$CONFIG_FILE" "$LINK_DIR/$CONFIG_FILE"

# Step 5: Reload Nginx
echo "Reloading Nginx..."
sudo systemctl reload nginx

# Deployment complete
echo "=== Deployment Complete! ==="
echo "Visit http://localhost to view your application."
