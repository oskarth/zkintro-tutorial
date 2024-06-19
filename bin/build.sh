#!/bin/bash

# This script builds a circuit from a specified Circom file.
# It requires a single argument: the path to the Circom file.
# The script outputs the compiled circuit files into a 'target' directory located in the same directory as the Circom file.

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path_to_circom_file>"
    exit 1
fi

CIRCOM_FILE=$1
TARGET_DIR=$(dirname "$CIRCOM_FILE")/target

echo "Building $CIRCOM_FILE circuit..."
mkdir -p "$TARGET_DIR"
circom "$CIRCOM_FILE" --r1cs --wasm --output "$TARGET_DIR"