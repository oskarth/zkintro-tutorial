# Define the tasks
prepare:
    ./bin/prepare.sh

build example:
    ./bin/build.sh {{example}}/{{example}}.circom

trusted_setup example:
    ./bin/trusted_setup.sh {{example}}/target/{{example}}.r1cs

trusted_setup_phase2 example:
    ./bin/trusted_setup_phase2.sh ptau/pot12.ptau {{example}}/target/{{example}}.r1cs

prove example:
    ./bin/prove.sh {{example}}/target/{{example}}_0001.zkey \
        {{example}}/target/{{example}}_js/{{example}}.wasm \
        {{example}}/input.json

# Define a task to run all steps sequentially for a specific example
all example:
    just prepare
    just build {{example}}
    just trusted_setup {{example}}
    just trusted_setup_phase2 ptau/pot12.ptau {{example}}/target/{{example}}.r1cs
    just prove {{example}}/target/{{example}}_0001.zkey {{example}}/target/{{example}}.wasm {{example}}/input.json
