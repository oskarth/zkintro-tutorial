#!/bin/bash

echo "Performing trusted setup..."

# Working directory
cd example/build

echo "Phase 1 of the trusted setup..."

# Start a new "powers of tau" ceremony
# Phase 1 is independent of the circuit
snarkjs powersoftau new bn128 12 pot12_0000.ptau -v

# Contribute to the powers of tau ceremony
snarkjs powersoftau contribute pot12_0000.ptau pot12_0001.ptau --name="Foo" -v

echo "Phase 2 of the trusted setup..."

# Start phase 2 - circuit-specific trusted setup
snarkjs powersoftau prepare phase2 pot12_0001.ptau pot12_final.ptau -v

# Generate a zkey file
snarkjs groth16 setup example.r1cs pot12_final.ptau example_0000.zkey

# Contribute to phase 2
snarkjs zkey contribute example_0000.zkey example_0001.zkey --name="Foo" -v

# Export verification key
snarkjs zkey export verificationkey example_0001.zkey verification_key.json

echo "Trusted setup completed."