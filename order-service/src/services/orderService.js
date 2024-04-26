const db = require('../config/firebaseInit');

exports.findAll = async () => {
    const snapshot = await db.collection('orders').get();
    return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
};

exports.create = async (data) => {
    const docRef = await db.collection('orders').add(data);
    return { id: docRef.id, ...data };
};

exports.findById = async (orderId) => {
    try {
        const order = await db.collection('orders').doc(orderId).get();
        if (!order.exists) {
            return null;
        }
        return { id: order.id, ...order.data() };
    } catch (error) {
        throw error;
    }
};

exports.cancel = async (orderId) => {
    const order = await db.collection('orders').doc(orderId).get();
    if (!order.exists) {
        throw new Error("Order not found");
    }

    await db.collection('orders').doc(orderId).update({
        status: 'canceled'
    });

    return { id: orderId, ...order.data(), status: 'canceled' };
};

exports.findAllByClientId = async (clientId) => {
    const snapshot = await db.collection('orders').where('clientId', '==', clientId).get();
    return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
};

exports.findAllByCookerId = async (cookerId) => {
    const snapshot = await db.collection('orders').where('cookerId', '==', cookerId).get();
    return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
};

exports.findAllByDelivererId = async (delivererId) => {
    const snapshot = await db.collection('orders').where('delivererId', '==', delivererId).get();
    return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
};
