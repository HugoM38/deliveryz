const kitchenService = require('../../services/kitchenService');

exports.getAllOrders = async (req, res) => {
    const cookerId = req.params.cookerId
    try {
        const orders = await kitchenService.findAllCookerId(cookerId);
        res.json(orders);
    } catch (error) {
        res.status(500).send(error.message);
    }
};

exports.switchStatus = async (req, res) => {
    const orderId = req.params.id;
    try {
        const order = await kitchenService.findById(orderId);
        if (!order) {
            return res.status(404).json({ message: "Order not found" });
        }
        if (order.status !== "pending") {
            return res.status(404).json({ message: "Order not pending" });
        }

        const account = await kitchenService.switchStatus(req.body);
        res.status(200).json(account);
    } catch (error) {
        res.status(400).send(error.message);
    }
};
