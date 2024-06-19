#!/bin/bash

# Description: Phase 2 of the trusted setup for zk-SNARKs using a circom file.
# Requires two arguments: <path_to_ptau_file> <path_to_circom_file>
# Produces: Verification key JSON file for the circom file.

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <path_to_ptau_file> <path_to_circom_file>"
    exit 1
fi

PROJECT_DIR=$PWD
PTAU_FILE=$1
CIRCOM_FILE=$2
CIRCOM_BASENAME=$(basename "$CIRCOM_FILE" .circom)
TARGET_DIR=$(dirname "$CIRCOM_FILE")/target

echo "Phase 2 of the trusted setup..."

cd "$TARGET_DIR"

# Start phase 2 - circuit-specific trusted setup
snarkjs powersoftau prepare phase2 "$PROJECT_DIR/$PTAU_FILE" pot12_final.ptau -v

# Generate a zkey file named according to the circom filename
snarkjs groth16 setup "${CIRCOM_BASENAME}.r1cs" pot12_final.ptau "${CIRCOM_BASENAME}_0000.zkey"

# Contribute to phase 2
snarkjs zkey contribute "${CIRCOM_BASENAME}_0000.zkey" "${CIRCOM_BASENAME}_0001.zkey" --name="Foo" -v

# Export verification key
snarkjs zkey export verificationkey "${CIRCOM_BASENAME}_0001.zkey" "${CIRCOM_BASENAME}_verification_key.json"

echo "Phase 2 of the trusted setup completed."