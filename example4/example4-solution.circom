pragma circom 2.0.0;

include "circomlib/circuits/poseidon.circom";

template SignMessage () {
  signal input identity_secret; 
  signal input identity_commitment;
  signal input message;
  signal output signature;

  // Identity commitment
  component identityHasher = Poseidon(1);
  identityHasher.inputs[0] <== identity_secret;
  identity_commitment === identityHasher.out;

  // Signature
  component signatureHasher = Poseidon(2);
  signatureHasher.inputs[0] <== identity_secret;
  signatureHasher.inputs[1] <== message;
  signature <== signatureHasher.out;
}

component main {public [identity_commitment, message]} = SignMessage();