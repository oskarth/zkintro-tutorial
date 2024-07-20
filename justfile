# Install tools and dependencies
prepare:
    ./scripts/prepare.sh

# Build a circuit, output .r1cs and .wasm files
build example:
    ./scripts/build.sh {{example}}/{{example}}.circom

# Run a trusted setup (both phases), output proving and verification keys
trusted_setup example:
    ./scripts/trusted_setup.sh {{example}}/target/{{example}}.r1cs

# Run a trusted setup using pot12, phase 2 only, output proving and verification keys
trusted_setup_phase2 example:
    ./scripts/trusted_setup_phase2.sh ptau/pot12.ptau {{example}}/target/{{example}}.r1cs

# Generate a proof, output proof and public output files
generate_proof example:
    ./scripts/generate_proof.sh {{example}}/target/{{example}}_0001.zkey \
        {{example}}/target/{{example}}_js/{{example}}.wasm \
        {{example}}/input.json

# Verifies a proof, output true or false
verify_proof example:
    ./scripts/verify_proof.sh {{example}}/target/{{example}}_verification_key.json \
        {{example}}/target/public.json \
        {{example}}/target/proof.json

generate_identity:
    ./scripts/generate_identity.sh

# Run all steps for a specific example
all example:
    just prepare
    just build {{example}}
    just trusted_setup {{example}}
    just trusted_setup_phase2 {{example}}
    just generate_proof {{example}}
    just verify_proof {{example}}