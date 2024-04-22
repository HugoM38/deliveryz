const db = require('../config/firebaseInit');

exports.findAll = async () => {
    const snapshot = await db.collection('clients').get();
    return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
};

exports.findByEmail = async (email) => {
    const snapshot = await db.collection('clients').where('email', '==', email).get();
    return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
}

exports.create = async (data) => {
    const docRef = await db.collection('clients').add(data);
    return { id: docRef.id, ...data };
};
