const express = require('express');
const router = express.Router();
const kitchenController = require('../controllers/kitchenController');

router.get('/orders/:cookerId', kitchenController.getAllOrdersId);
router.put('/orders/:id', kitchenController.orderReady);
// Gerer le menu GET ADD DELETE
router.get("/menu/:cookerId", kitchenController.getMenu)
router.post("/menu/:cookerId", kitchenController.addItemToMenu)
router.put("/menu/:cookerId", kitchenController.removeItemFromMenu)
// Recuperer tout les "kichen"
router.get("/", kitchenController.getAllCooker)
module.exports = router;
