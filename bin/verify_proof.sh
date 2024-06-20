#!/bin/bash

# Script to verify a zk-SNARK proof using snarkjs.
# Usage: ./verify_proof.sh <verification_key> <public_output> <proof_file>
# Example: ./verify_proof.sh verification_key.json public.json proof.json

set -euo pipefail

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <verification_key> <public_output> <proof_file>"
    exit 1
fi

echo "Verifying the proof..."

VERIFICATION_KEY=$1
PUBLIC_OUTPUT=$2
PROOF_FILE=$3

if snarkjs groth16 verify $VERIFICATION_KEY $PUBLIC_OUTPUT $PROOF_FILE; then
    echo "Proof verified."
else
    echo "Proof verification failed."
fi