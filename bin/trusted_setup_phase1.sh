#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <target_directory>"
    exit 1
fi

TARGET_DIR=$1

echo "Phase 1 of the trusted setup..."

# Working directory
mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"

# Start a new "powers of tau" ceremony
# Phase 1 is independent of the circuit
snarkjs powersoftau new bn128 12 pot12_0000.ptau -v

# Contribute to the powers of tau ceremony
snarkjs powersoftau contribute pot12_0000.ptau pot12_0001.ptau --name="Foo" -v

echo "Phase 1 of the trusted setup completed."