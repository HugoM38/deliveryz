const accountService = require('../../services/accountService');

exports.getAllAccounts = async (req, res) => {
    try {
        const accounts = await accountService.findAll();
        res.json(accounts);
    } catch (error) {
        res.status(500).send(error.message);
    }
};

exports.createAccount = async (req, res) => {
    try {
        const account = await accountService.create(req.body);
        res.status(201).json(account);
    } catch (error) {
        res.status(400).send(error.message);
    }
};
