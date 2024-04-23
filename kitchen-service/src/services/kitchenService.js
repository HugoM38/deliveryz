const db = require('../config/firebaseInit');

exports.findAllCookerId = async (cookerId) => {
    try {
        const ordersSnapshot = await db.collection('orders').where('cookerId', '==', cookerId).get();

        const orders = [];
        ordersSnapshot.forEach(doc => {
            orders.push({ id: doc.id, ...doc.data() });
        });

        return orders;
    } catch (error) {
        console.error("Error fetching orders: ", error);
        throw error;
    }
};
exports.switchStatus = async (orderId) => {
    try {
        const order = await db.collection('orders').doc(orderId).get();
        if (!order.exists) {
            return new Error("Order not found");
        }
        await db.collection('orders').doc(orderId).update({
            status: 'ready'
        });
    } catch (error) {
        throw error;
    }
};

exports.findById = async (orderId) => {
    try {
        const order = await db.collection('orders').doc(orderId).get();
        if (!order.exists) {
            return new Error("Order not found");
        }
        return { id: order.id, ...order.data() };
    } catch (error) {
        throw error;
    }
};
