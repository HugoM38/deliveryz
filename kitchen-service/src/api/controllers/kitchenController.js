const kitchenService = require('../../services/kitchenService');

exports.getAllOrdersId = async (req, res) => {
    const cookerId = req.params.cookerId
    try {
        const orders = await kitchenService.findAllCookerId(cookerId);
        res.json(orders);
    } catch (error) {
        res.status(500).send(error.message);
    }
};

exports.getAllCooker = async (req, res) => {
    try {
        const orders = await kitchenService.findAllCooker();
        res.json(orders);
    } catch (error) {
        res.status(500).send(error.message);
    }
};

exports.orderReady = async (req, res) => {
    const orderId = req.params.id;
    try {
        const order = await kitchenService.findById(orderId);
        if (!order) {
            return res.status(404).json({ message: "Order not found" });
        }
        if (order.status !== "pending") {
            return res.status(404).json({ message: "Order not pending" });
        }

        const account = await kitchenService.orderReady(req.body);
        res.status(200).json(account);
    } catch (error) {
        res.status(400).send(error.message);
    }
};

exports.getMenu = async (req, res)=> {
    const cookerId = req.params.cookerId
    try {
        const orders = await kitchenService.getMenu(cookerId);
        res.json(orders);
    } catch (err){
        res.status(500).send(err.message)
    }
}

exports.addItemToMenu = async (req, res) => {
    try {
        const cookerId = req.params.cookerId;
        const newItem = req.body;
        const menu = await kitchenService.addItemToMenu(cookerId, newItem);
        res.json(menu);
    } catch (error) {
        res.status(500).send(error.message);
    }
};

exports.removeItemFromMenu = async (req, res) => {
    const cookerId = req.params.cookerId;
    const itemId = req.body;
    try {
        const result = await kitchenService.removeItemFromMenu(cookerId, itemId.itemId);
        res.json(result);
    } catch (error) {
        res.status(500).send(error.message);
    }
};


