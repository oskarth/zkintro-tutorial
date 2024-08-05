pragma circom 2.0.0;

include "circomlib/circuits/poseidon.circom";

template SignMessage (n) {
  signal input identity_secret; 
  signal input identity_commitments[n];
  signal input message;
  signal output signature;

  // Identity commitment
  component identityHasher = Poseidon(1);
  identityHasher.inputs[0] <== identity_secret;
  signal myIdentity <== identityHasher.out;

  // Signature
  component signatureHasher = Poseidon(2);
  signatureHasher.inputs[0] <== identity_secret;
  signatureHasher.inputs[1] <== message;
  signature <== signatureHasher.out;

  // Membership check
  // Assuming three identities in total
  // Checking if (myId - id0)(myId - id1)(myId - id2)... === 0
  signal temp[n];
  temp[0] <== myIdentity - identity_commitments[0];
  for (var i = 1; i < n; i++) {
    temp[i] <== temp[i-1] * (myIdentity - identity_commitments[i]);
  }

  // Enforce that myIdentity is among the identity_commitments
  temp[n-1] === 0;
}

component main {public [identity_commitments, message]} = SignMessage(3);