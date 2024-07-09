# Define the tasks
prepare:
    ./scripts/prepare.sh

build example:
    ./scripts/build.sh {{example}}/{{example}}.circom

trusted_setup example:
    ./scripts/trusted_setup.sh {{example}}/target/{{example}}.r1cs

trusted_setup_phase2 example:
    ./scripts/trusted_setup_phase2.sh ptau/pot12.ptau {{example}}/target/{{example}}.r1cs

generate_proof example:
    ./scripts/generate_proof.sh {{example}}/target/{{example}}_0001.zkey \
        {{example}}/target/{{example}}_js/{{example}}.wasm \
        {{example}}/input.json

verify_proof example:
    ./scripts/verify_proof.sh {{example}}/target/{{example}}_verification_key.json \
        {{example}}/target/public.json \
        {{example}}/target/proof.json

# Define a task to run all steps sequentially for a specific example
all example:
    just prepare
    just build {{example}}
    just trusted_setup {{example}}
    just trusted_setup_phase2 {{example}}
    just generate_proof {{example}}
    just verify_proof {{example}}