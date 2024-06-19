# Define the tasks
prepare:
    ./bin/prepare.sh

build example:
    ./bin/build.sh {{example}}/{{example}}.circom

trusted_setup example:
    ./bin/trusted_setup.sh {{example}}/target/{{example}}.r1cs

prove example:
    ./bin/prove.sh {{example}}/target/{{example}}.zkey {{example}}/target/{{example}}.wasm {{example}}/input.json

# Define a task to run all steps sequentially for a specific example
all example:
    just prepare
    just build {{example}}
    just trusted_setup {{example}}
    just prove {{example}}
