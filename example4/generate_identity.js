const circomlibjs = require('circomlibjs');
const crypto = require('crypto');

// Generate a random secret
function generateRandomSecret() {
    return BigInt('0x' + crypto.randomBytes(32).toString('hex'));
}

// Generate identity secret and commitment
async function generateIdentity() {
    const identitySecret = generateRandomSecret();
    const poseidon = await circomlibjs.buildPoseidon();
    const identityCommitment = poseidon.F.toString(poseidon([identitySecret]));

    console.log('identity_secret:', identitySecret.toString());
    console.log('identity_commitment:', identityCommitment);
}

generateIdentity().catch(err => {
    console.error('Error generating identity:', err);
});