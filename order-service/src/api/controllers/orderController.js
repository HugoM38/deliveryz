const orderService = require('../../services/orderService');
const { validateOrder } = require('../validators/orderValidator');


exports.getAllOrders = async (req, res) => {
    try {
        const orders = await orderService.findAll();
        res.json(orders);
    } catch (error) {
        next(error);
    }
};

exports.createOrder = async (req, res) => {
    const { error } = validateOrder(req.body);
    if (error) return res.status(400).send(error.details[0].message);

    try {
        const order = await orderService.create(req.body);
        res.status(201).json(order);
    } catch (error) {
        next(error);
    }
};

exports.cancelOrder = async (req, res, next) => {
    const orderId = req.params.id;

    try {
        const order = await orderService.findById(orderId);
        if (!order) {
            return res.status(404).json({ message: "Order not found" });
        }

        if (order.status !== 'pending') {
            return res.status(400).json({ message: "Order cannot be canceled, as it is not in pending status" });
        }

        const canceledOrder = await orderService.cancel(orderId);
        res.status(200).json({ message: "Order canceled successfully", order: canceledOrder });
    } catch (error) {
        next(error);
    }
};
