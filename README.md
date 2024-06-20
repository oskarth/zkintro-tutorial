# zkintro tutorial

Repository for zkintro tutorial.

## How to get started

These instructions should work for OSX and most Linux distributions. If you use Windows we suggest running a Linux VM for development.

Replace `example` with one of the examples, such as `example` or `example2`.

```
# Install dependencies (`just`, `rust`, `circom`, `snarkjs`)
./bin/prepare.sh

# Build circuit
just build example

# Perform trusted setup (phase 1 and 2)
just trusted_setup example

# Generate a proof
just generate_proof example

# Verify the proof
just verify_proof example
```

If you just want to run phase 2 of the trusted setup, use `just trusted_setup_phase2 example`.