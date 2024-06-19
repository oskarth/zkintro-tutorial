#!/bin/bash

# Script for Phase 1 of zk-SNARKs trusted setup using snarkjs. Initializes and contributes to a "powers of tau" ceremony.
# Requires: target_directory for storing the ceremony artifact.
# Produces: ptau/pot12.ptau - Powers of tau file after Phase 1.

set -euo pipefail

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <target_directory>"
    exit 1
fi

PROJECT_DIR=$PWD
TARGET_DIR=$1

echo "Starting Phase 1 of the trusted setup..."

# Create and navigate to the target directory
mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"

# Initialize and contribute to the "powers of tau" ceremony
snarkjs powersoftau new bn128 12 pot12_0000.ptau -v
snarkjs powersoftau contribute pot12_0000.ptau pot12_0001.ptau --name="Foo" -v

# Store the artifact after Phase 1
mkdir -p $PROJECT_DIR/ptau
cp pot12_0001.ptau $PROJECT_DIR/ptau/pot12.ptau

echo "Phase 1 of the trusted setup completed."