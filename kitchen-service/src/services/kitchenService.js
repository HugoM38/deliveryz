const db = require('../config/firebaseInit');
const {firestore} = require("firebase-admin");

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
exports.orderReady = async (orderId) => {
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

exports.getAllCooker = async () => {
    try {
        const cookers = await db.collection('cookers').get()
        return cookers.docs.map(doc => ({ id: doc.id, ...doc.data() }));
    } catch (error) {
        throw error
    }
}

exports.getMenu = async (cookerId) => {
    try {
        const cookerDoc = await db.collection('cookers').doc(cookerId).get();

        if (!cookerDoc.exists) {
            return new Error('Cooker not found');
        }

        const cookerData = cookerDoc.data();
        if (!cookerData.menu || !Array.isArray(cookerData.menu)) {
            return new Error('Menu not found or invalid format');
        }

        return cookerData.menu.filter(item => {
            return item.name && item.price;
        });
    } catch (error) {
        console.error("Error fetching menu: ", error);
        throw error; // Gérer l'erreur ou la propager vers l'appelant
    }
};

exports.addItemToMenu = async (cookerId, newItem) => {
    try {
        const cookerRef = db.collection('cookers').doc(cookerId);
        const cookerDoc = await cookerRef.get();

        if (!cookerDoc.exists) {
            throw new Error('Cooker not found');
        }
        const menu = cookerDoc.data().menu || [];
        const maxId = menu.reduce((max, item) => {
            return item.id > max ? item.id : max;
        }, 0);
        newItem.id = maxId + 1;

        await cookerRef.update({
            menu: [...menu, newItem]
        });

        return "Item added to menu successfully";
    } catch (error) {
        console.error("Error adding item to menu: ", error);
    }
};

exports.removeItemFromMenu = async (cookerId, itemId) => {
    try {
        const cookerRef = db.collection('cookers').doc(cookerId);
        const cookerDoc = await cookerRef.get();
        if (!cookerDoc.exists) {
            throw new Error('Cooker not found');
        }
        const menu = cookerDoc.data().menu || [];
        if (itemId > menu.length || itemId < 0) {
            throw new Error('Item not found')
        }
        const updatedMenu = menu.filter(item => {
            return item.id !== itemId;
        });
        const updatedMenuWithNewIds = updatedMenu.map((item, index) => {
            return { ...item, id: index };
        });
        await cookerRef.update({
            menu: updatedMenuWithNewIds
        });

        return "Item removed from menu successfully";
    } catch (error) {
        console.error("Error removing item from menu: ", error);
    }
};





