const express = require('express');
const router = express.Router();
const kitchenController = require('../controllers/kitchenController');

router.get('/orders/:cookerId', kitchenController.getAllOrders);
router.put('/orders/:id', kitchenController.switchStatus);

module.exports = router;
