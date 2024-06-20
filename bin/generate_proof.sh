#!/bin/bash

set -euo pipefail

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <zkey_path> <wasm_path> <input_json_path>"
    exit 1
fi

ZKEY_PATH=$1
WASM_PATH=$2
INPUT_JSON_PATH=$3
EXAMPLE_NAME=$(basename "$WASM_PATH" .wasm)
TARGET_DIR=$(dirname "$ZKEY_PATH")
WITNESS_PATH=$TARGET_DIR/witness.wtns

echo "Generating the proof for $EXAMPLE_NAME..."

# Generate the witness
node utils/generate_witness.js $WASM_PATH $INPUT_JSON_PATH $WITNESS_PATH

# Generate the proof
snarkjs groth16 prove $ZKEY_PATH $WITNESS_PATH $TARGET_DIR/proof.json $TARGET_DIR/public.json

echo "Proof generated."
echo "Proof: $TARGET_DIR/proof.json"
echo "Public output: $TARGET_DIR/public.json"