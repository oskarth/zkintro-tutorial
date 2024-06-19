#!/bin/bash

# This script orchestrates the trusted setup for zk-SNARKs using a given circom file.
# It requires a single argument: the path to the circom file.
# The script performs both Phase 1 and Phase 2 of the trusted setup.

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path_to_circom_file>"
    exit 1
fi

CIRCOM_FILE=$1
CIRCOM_BASENAME=$(basename "$CIRCOM_FILE" .circom)
TARGET_DIR=$(dirname "$CIRCOM_FILE")/target
PTAU_FILE="ptau/pot12.ptau"

echo "Performing trusted setup..."

./bin/trusted_setup_phase1.sh "$TARGET_DIR"
./bin/trusted_setup_phase2.sh "$PTAU_FILE" "$CIRCOM_FILE"

echo "Trusted setup completed."