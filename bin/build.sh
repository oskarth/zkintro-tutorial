#!/bin/bash

echo "Building example.circom circuit..."
circom example/example.circom --r1cs --wasm --output example/build