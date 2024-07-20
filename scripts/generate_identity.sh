#!/bin/bash

(
  cd example3

  # Install npm dependencies if node_modules does not exist
  if [ ! -d "node_modules" ]; then
      npm install
  fi

  # Run the script to generate identity secret and identity commitment
  node generate_identity.js
)
