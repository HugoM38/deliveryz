const db = require('../config/firebaseInit');

exports.findAll = async () => {
    const snapshot = await db.collection('accounts').get();
    return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
};

exports.create = async (data) => {
    const docRef = await db.collection('accounts').add(data);
    return { id: docRef.id, ...data };
};
