#!/bin/bash

# Description: Phase 2 of the trusted setup for zk-SNARKs using an R1CS file.
# Requires two arguments: <path_to_ptau_file> <path_to_r1cs_file>
# Produces: Verification key JSON file for the R1CS file.

set -euo pipefail

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <path_to_ptau_file> <path_to_r1cs_file>"
    exit 1
fi

PROJECT_DIR=$PWD
PTAU_FILE=$1
R1CS_FILE=$2
R1CS_BASENAME=$(basename "$R1CS_FILE" .r1cs)
TARGET_DIR=$(dirname "$R1CS_FILE")

echo "Phase 2 of the trusted setup..."

cd "$TARGET_DIR"

# Start phase 2 - circuit-specific trusted setup
snarkjs powersoftau prepare phase2 "$PROJECT_DIR/$PTAU_FILE" pot12_final.ptau -v

# Generate a zkey file named according to the R1CS filename
snarkjs groth16 setup "${R1CS_BASENAME}.r1cs" pot12_final.ptau "${R1CS_BASENAME}_0000.zkey"

# Contribute to phase 2
snarkjs zkey contribute "${R1CS_BASENAME}_0000.zkey" "${R1CS_BASENAME}_0001.zkey" --name="Foo" -v

# Export verification key
snarkjs zkey export verificationkey "${R1CS_BASENAME}_0001.zkey" "${R1CS_BASENAME}_verification_key.json"

echo "Phase 2 of the trusted setup completed."
echo "zkey proving key: $TARGET_DIR/${R1CS_BASENAME}_0001.zkey"
echo "verification key: $TARGET_DIR/${R1CS_BASENAME}_verification_key.json"