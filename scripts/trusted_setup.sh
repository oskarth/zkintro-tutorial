#!/bin/bash

# This script orchestrates the trusted setup for zk-SNARKs using a given R1CS file.
# It requires a single argument: the path to the R1CS file.
# The script performs both Phase 1 and Phase 2 of the trusted setup.

set -euo pipefail

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path_to_r1cs_file>"
    exit 1
fi

R1CS_FILE=$1
R1CS_BASENAME=$(basename "$R1CS_FILE" .r1cs)
TARGET_DIR=$(dirname "$R1CS_FILE")
PTAU_FILE="ptau/pot12.ptau"

echo "Performing trusted setup..."

./scripts/trusted_setup_phase1.sh "$TARGET_DIR"
./scripts/trusted_setup_phase2.sh "$PTAU_FILE" "$R1CS_FILE"

echo "Trusted setup completed."
echo "zkey proving key: $TARGET_DIR/${R1CS_BASENAME}_0001.zkey"
echo "verification key: $TARGET_DIR/${R1CS_BASENAME}_verification_key.json"
