#!/bin/bash

# Function to check if just is already installed
check_just_installed() {
    if command -v just &> /dev/null; then
        echo "just is already installed. Skipping installation."
        exit 0
    fi
}

# Define install functions for different operating systems
install_macos() {
    echo "Installing just on macOS..."
    brew install just
}

install_linux() {
    echo "Installing just on Linux..."
    
    # Check if apt-get is available (Debian/Ubuntu)
    if command -v apt-get &> /dev/null; then
        sudo apt-get update
        sudo apt-get install -y just
    
    # Check if dnf is available (Fedora)  
    elif command -v dnf &> /dev/null; then  
        sudo dnf install -y just
    
    # Check if yum is available (CentOS/RHEL)
    elif command -v yum &> /dev/null; then
        sudo yum install -y just
    
    # Check if zypper is available (openSUSE)
    elif command -v zypper &> /dev/null; then  
        sudo zypper install -y just
    
    else
        echo "Error: Package manager not found. Please install just manually."
        exit 1
    fi
}

# Check if just is already installed
check_just_installed


# Detect operating system
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    if command -v brew &> /dev/null; then
        install_macos
    else
        echo "Error: Homebrew not found. Please install Homebrew first."
        exit 1
    fi
else
    # Linux
    install_linux
fi