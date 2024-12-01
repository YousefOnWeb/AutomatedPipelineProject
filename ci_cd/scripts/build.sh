#!/bin/bash

# Navigate to the application directory
cd app

# Install the dependencies using pip
echo "Installing dependencies..."
pip install -r requirements.txt

# (Optional) Build a deployable artifact, for example, a Docker image (if applicable)
# docker build -t your-app-image .

echo "App built successfully!"
