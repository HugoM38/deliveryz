const admin = require('firebase-admin');
const firebaseSecrets = require('../../../firebase-secrets.json');

admin.initializeApp({
    credential: admin.credential.cert(firebaseSecrets)
});

const db = admin.firestore();

module.exports = db;
