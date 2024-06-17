#!/bin/bash

echo "Verifying the proof..."

# Working directory
cd example/target

snarkjs groth16 verify verification_key.json public.json proof.json

echo "Proof verified."