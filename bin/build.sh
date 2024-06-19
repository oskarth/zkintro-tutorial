#!/bin/bash

# This script builds a circuit from a specified Circom file.
# It requires a single argument: the path to the Circom file.
# The script outputs the compiled circuit files into a 'target' directory located in the same directory as the Circom file.
# It also copies the wasm file from the example_js folder to the target folder.

set -euo pipefail

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path_to_circom_file>"
    exit 1
fi

CIRCOM_FILE=$1
TARGET_DIR=$(dirname "$CIRCOM_FILE")/target
EXAMPLE_JS_DIR=$(dirname "$CIRCOM_FILE")/example_js

echo "Building $CIRCOM_FILE circuit..."
mkdir -p "$TARGET_DIR"
circom "$CIRCOM_FILE" --r1cs --wasm --output "$TARGET_DIR"

echo "Copying wasm file from $EXAMPLE_JS_DIR to $TARGET_DIR..."
cp "$EXAMPLE_JS_DIR/example.wasm" "$TARGET_DIR"