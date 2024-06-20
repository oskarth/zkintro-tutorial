#!/bin/bash

echo "Verifying the proof..."

# Working directory
cd example/target

if snarkjs groth16 verify verification_key.json public.json proof.json; then
    echo "Proof verified."
else
    echo "Proof verification failed."
fi
