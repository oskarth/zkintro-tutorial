const circomlibjs = require('circomlibjs');
const crypto = require('crypto');

// Function to generate a random field element
function generateRandomFieldElement() {
    const buffer = crypto.randomBytes(32);
    return BigInt('0x' + buffer.toString('hex'));
}

// Generate identity_secret
const identity_secret = generateRandomFieldElement();
console.log('identity_secret:', identity_secret.toString());

// Generate identity_commitment using Poseidon hash
async function generateIdentityCommitment(secret) {
    const poseidon = await circomlibjs.buildPoseidon();
    const poseidonHash = poseidon.F.toString(poseidon([secret]));
    return poseidonHash;
}

generateIdentityCommitment(identity_secret).then(identity_commitment => {
    console.log('identity_commitment:', identity_commitment);
}).catch(err => {
    console.error('Error generating identity_commitment:', err);
});