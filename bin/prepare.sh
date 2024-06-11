#!/bin/bash

# Directory to install Circom
read -p "Enter directory to install Circom (default: \$HOME/circom): " CIRCOM_INSTALL_DIR
CIRCOM_INSTALL_DIR=${CIRCOM_INSTALL_DIR:-"$HOME/circom"}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install Rust
install_rust() {
    if ! command_exists rustc; then
        echo "Rust is not installed. Installing Rust..."
        curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
        source $HOME/.cargo/env
    else
        echo "Rust is already installed."
    fi
}

# Function to install Circom
install_circom() {
    if ! command_exists circom; then
        echo "Circom is not installed. Installing Circom..."
        if [ ! -d "$CIRCOM_INSTALL_DIR" ]; then
            echo "Cloning Circom repository..."
            git clone https://github.com/iden3/circom.git "$CIRCOM_INSTALL_DIR"
            cd "$CIRCOM_INSTALL_DIR"
            echo "Building Circom (this might take a few minutes)..."
            cargo build --release
            echo "Installing Circom locally..."
            cargo install --path ./circom
            cd ..
        else
            echo "Circom repository already exists in $CIRCOM_INSTALL_DIR. Skipping clone and build."
        fi
    else
        echo "Circom is already installed."
    fi
}

# Function to install snarkjs
install_snarkjs() {
    if ! command_exists snarkjs; then
        echo "snarkjs is not installed. Installing snarkjs..."
        if command_exists npm; then
            echo "Installing snarkjs..."
            npm install -g snarkjs@latest
        else
            echo "npm is not installed. Please install npm and rerun the script."
            exit 1
        fi
    else
        echo "snarkjs is already installed."
    fi
}

# Main function to orchestrate the installation
main() {
    install_rust
    install_circom
    install_snarkjs
    echo "Installation completed."
}

# Execute the main function
main