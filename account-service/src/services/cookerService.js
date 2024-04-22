const db = require('../config/firebaseInit');

exports.findAll = async () => {
    const snapshot = await db.collection('cookers').get();
    return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
};

exports.findByEmail = async (email) => {
    const snapshot = await db.collection('cookers').where('email', '==', email).get();
    return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
}

exports.create = async (data) => {
    const docRef = await db.collection('cookers').add(data);
    return { id: docRef.id, ...data };
};
