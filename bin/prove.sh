#!/bin/bash

echo "Generating the proof..."

# Copy input.json to the build directory
cp example/input.json example/target

# Working directory
cd example/target

# Generate the witness
node example_js/generate_witness.js example_js/example.wasm input.json witness.wtns

# Generate the proof
snarkjs groth16 prove example_0001.zkey witness.wtns proof.json public.json

echo "Proof generated."