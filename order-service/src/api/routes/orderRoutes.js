const express = require('express');
const router = express.Router();
const orderController = require('../controllers/orderController');

router.get('/', orderController.getAllOrders);
router.post('/', orderController.createOrder);
router.put('/cancel/:id', orderController.cancelOrder);

router.get('/clients/:clientId', orderController.getOrdersByClientId);
router.get('/cookers/:cookerId', orderController.getOrdersByCookerId);
router.get('/deliverers/:delivererId', orderController.getOrdersByDelivererId);


module.exports = router;