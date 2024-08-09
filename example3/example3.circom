pragma circom 2.0.0;

include "circomlib/circuits/poseidon.circom";

template SignMessage () {
  signal input identity_secret; 
  signal input identity_commitment;
  signal input message;
  signal output signature;

  // Identity commitment
  // TODO: Create the identity commitment with Poseidon(1)

  // Signature
  // TODO: Create the signature with Poseidon(2)
}

component main {public [identity_commitment, message]} = SignMessage();