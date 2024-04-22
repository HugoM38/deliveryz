const express = require('express');
const router = express.Router();
const clientController = require('../controllers/clientController');
const cookerController = require('../controllers/cookerController');
const delivererController = require('../controllers/delivererController');

router.get('/clients/', clientController.getAllClients);
router.post('/clients/', clientController.createClient);
router.post('/clients/login', clientController.loginClient);

router.get('/cookers/', cookerController.getAllCookers);
router.post('/cookers/', cookerController.createCooker);
router.post('/cookers/login', cookerController.loginCooker);

router.get('/deliverers/', delivererController.getAllDeliverers);
router.post('/deliverers/', delivererController.createDeliverer);
router.post('/deliverers/login', delivererController.loginDeliverer);


module.exports = router;
