# zkintro tutorial

Repository for zkintro tutorial.

See https://zkintro.com/articles/programming-zkps-from-zero-to-hero for context.

## How to get started

These instructions should work for OSX and most Linux distributions. If you use Windows we suggest running a Linux VM for development.

Replace `example` with one of the examples, such as `example1` or `example2`.

*NOTE: The current `circom` circuits are unfinished. To build them they need to be completed. If you get stuck, see files named `*-solution.circom`.*

```
# Install dependencies (`just`, `rust`, `circom`, `snarkjs`)
./scripts/prepare.sh

# Build circuit
just build example1

# Perform trusted setup (phase 1 and 2)
just trusted_setup example1

# Generate a proof
just generate_proof example1

# Verify the proof
just verify_proof example1
```

## Other commands

Only run phase 2 of the trusted setup with:

```
just trusted_setup_phase2 example2
```

Generate identity key pair (`identity_secret` and `identity_commitment`):

```
just generate_identity
```