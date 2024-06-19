#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path_to_circom_file>"
    exit 1
fi

CIRCOM_FILE=$1
CIRCOM_BASENAME=$(basename "$CIRCOM_FILE" .circom)
TARGET_DIR=$(dirname "$CIRCOM_FILE")/target

echo "Performing trusted setup..."

# Working directory
mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"

echo "Phase 1 of the trusted setup..."

# Start a new "powers of tau" ceremony
# Phase 1 is independent of the circuit
snarkjs powersoftau new bn128 12 pot12_0000.ptau -v

# Contribute to the powers of tau ceremony
snarkjs powersoftau contribute pot12_0000.ptau pot12_0001.ptau --name="Foo" -v

echo "Phase 2 of the trusted setup..."

# Start phase 2 - circuit-specific trusted setup
snarkjs powersoftau prepare phase2 pot12_0001.ptau pot12_final.ptau -v

# Generate a zkey file named according to the circom filename
snarkjs groth16 setup "${CIRCOM_BASENAME}.r1cs" pot12_final.ptau "${CIRCOM_BASENAME}_0000.zkey"

# Contribute to phase 2
snarkjs zkey contribute "${CIRCOM_BASENAME}_0000.zkey" "${CIRCOM_BASENAME}_0001.zkey" --name="Foo" -v

# Export verification key
snarkjs zkey export verificationkey "${CIRCOM_BASENAME}_0001.zkey" "${CIRCOM_BASENAME}_verification_key.json"

echo "Trusted setup completed."