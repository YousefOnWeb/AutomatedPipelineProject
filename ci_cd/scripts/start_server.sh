#!/bin/bash

# Restart Nginx if that's being used
echo "Starting Nginx server..."
sudo systemctl restart nginx

echo "Web server started successfully!"
