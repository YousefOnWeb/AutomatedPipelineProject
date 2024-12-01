#!/bin/bash

# This script automates the installation and configuration of Prometheus and Grafana
# for monitoring purposes, based on the provided configuration files.
# Prometheus and Grafana will only be installed if they are not already installed.

# Function to check if Prometheus is installed
check_prometheus_installed() {
    if command -v prometheus &> /dev/null; then
        echo "Prometheus is already installed."
        return 0
    else
        return 1
    fi
}

# Function to check if Grafana is installed
check_grafana_installed() {
    if command -v grafana-server &> /dev/null; then
        echo "Grafana is already installed."
        return 0
    else
        return 1
    fi
}

# Function to install Prometheus
install_prometheus() {
    echo "Installing Prometheus..."
    
    # Download and install Prometheus
    wget https://github.com/prometheus/prometheus/releases/download/v2.46.0/prometheus-2.46.0.linux-amd64.tar.gz
    tar -xvzf prometheus-2.46.0.linux-amd64.tar.gz
    sudo mv prometheus-2.46.0.linux-amd64/prometheus /usr/local/bin/
    sudo mv prometheus-2.46.0.linux-amd64/promtool /usr/local/bin/
    sudo mkdir -p /etc/prometheus
    sudo mv prometheus-2.46.0.linux-amd64/prometheus.yml /etc/prometheus/
    
    # Clean up the downloaded files
    rm -rf prometheus-2.46.0.linux-amd64.tar.gz prometheus-2.46.0.linux-amd64
    
    # Start Prometheus
    sudo systemctl start prometheus
    sudo systemctl enable prometheus
    
    echo "Prometheus installation complete."
}

# Function to install Grafana
install_grafana() {
    echo "Installing Grafana..."
    
    # Add Grafana repository and install
    sudo apt-get install -y software-properties-common
    sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
    sudo apt-get update
    sudo apt-get install grafana
    
    # Start and enable Grafana service
    sudo systemctl start grafana-server
    sudo systemctl enable grafana-server
    
    echo "Grafana installation complete."
}

# Function to set up Prometheus configuration
setup_prometheus_config() {
    echo "Setting up Prometheus configuration..."
    
    # Ensure the prometheus.yml file exists
    if [ -f prometheus.yml ]; then
        sudo mv prometheus.yml /etc/prometheus/
    else
        echo "Error: prometheus.yml file not found!"
        exit 1
    fi
    
    # Start Prometheus service if not running
    if ! systemctl is-active --quiet prometheus; then
        sudo systemctl start prometheus
    fi
    
    sudo systemctl enable prometheus
    
    echo "Prometheus configuration setup complete."
}

# Function to set up Grafana
setup_grafana() {
    echo "Setting up Grafana..."
    
    # Ensure Grafana datasource file exists
    if [ -f grafana/datasources/prometheus.yml ]; then
        sudo mkdir -p /etc/grafana/provisioning/datasources
        sudo mv grafana/datasources/prometheus.yml /etc/grafana/provisioning/datasources/
    else
        echo "Error: prometheus.yml for Grafana datasource not found!"
        exit 1
    fi
    
    # Ensure Grafana dashboard JSON file exists
    if [ -f grafana/dashboards/cpu_memory_dashboard.json ]; then
        sudo mkdir -p /etc/grafana/provisioning/dashboards
        sudo mv grafana/dashboards/cpu_memory_dashboard.json /etc/grafana/provisioning/dashboards/
    else
        echo "Error: Grafana dashboard JSON file not found!"
        exit 1
    fi
    
    # Restart Grafana to apply changes
    sudo systemctl restart grafana-server
    
    echo "Grafana configuration setup complete."
}

# Function to display installation status
installation_status() {
    echo "Installation complete. Access the following services:"
    echo "Prometheus: http://localhost:9090"
    echo "Grafana: http://localhost:3000 (default login: admin/admin)"
}

# Main script execution
if ! check_prometheus_installed; then
    install_prometheus
fi

if ! check_grafana_installed; then
    install_grafana
fi

setup_prometheus_config
setup_grafana
installation_status
