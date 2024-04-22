const express = require('express');
const router = express.Router();
const accountController = require('../controllers/accountController');
const authenticateToken = require('../middlewares/authenticateToken');

router.get('/', accountController.getAllAccounts);
router.post('/', accountController.createAccount);
router.post('/login', accountController.login);

module.exports = router;
