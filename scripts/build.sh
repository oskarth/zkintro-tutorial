#!/bin/bash

# Build a circuit from a Circom file.
# Requires 1 argument: path to Circom file.
# Outputs compiled files to 'target' directory.

set -euo pipefail

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path_to_circom_file>"
    exit 1
fi

CIRCOM_FILE=$1
TARGET_DIR=$(dirname "$CIRCOM_FILE")/target

if [ -f "$(dirname "$CIRCOM_FILE")/package.json" ]; then
    echo "package.json found, running npm install..."
    npm install --prefix "$(dirname "$CIRCOM_FILE")"
fi

echo "Building $CIRCOM_FILE circuit..."
mkdir -p "$TARGET_DIR"
circom "$CIRCOM_FILE" --r1cs --wasm --output "$TARGET_DIR"
