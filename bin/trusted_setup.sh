#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path_to_circom_file>"
    exit 1
fi

CIRCOM_FILE=$1
CIRCOM_BASENAME=$(basename "$CIRCOM_FILE" .circom)
TARGET_DIR=$(dirname "$CIRCOM_FILE")/target

echo "Performing trusted setup..."

./bin/trusted_setup_phase1.sh "$TARGET_DIR"
./bin/trusted_setup_phase2.sh "$CIRCOM_FILE"

echo "Trusted setup completed."