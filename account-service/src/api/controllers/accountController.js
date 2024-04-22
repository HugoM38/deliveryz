const accountService = require('../../services/accountService');
const { validateAccount } = require('../validators/accountValidator');

exports.getAllAccounts = async (req, res) => {
    try {
        const accounts = await accountService.findAll();
        res.json(accounts);
    } catch (error) {
        res.status(500).send(error.message);
    }
};

exports.createAccount = async (req, res) => {
    const { error } = validateAccount(req.body);
    if (error) return res.status(400).send(error.details[0].message);

    try {
        const existingAccount = await accountService.findByEmail(req.body.email);
        if (existingAccount.length > 0) {
            return res.status(400).send('Account with this email already exists');
        }
        const account = await accountService.create(req.body);
        res.status(201).json(account);
    } catch (error) {
        res.status(500).send(error.message);
    }
};
