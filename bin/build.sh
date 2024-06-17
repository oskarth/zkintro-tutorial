#!/bin/bash

echo "Building example.circom circuit..."
mkdir -p example/target
circom example/example.circom --r1cs --wasm --output example/target