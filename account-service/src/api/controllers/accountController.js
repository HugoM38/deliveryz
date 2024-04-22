const accountService = require('../../services/accountService');
const authService = require('../../services/authService');
const { validateSignup } = require('../validators/signupValidator');
const { validateLogin } = require('../validators/loginValidator');

exports.getAllAccounts = async (req, res) => {
    try {
        const accounts = await accountService.findAll();
        res.json(accounts);
    } catch (error) {
        res.status(500).send(error.message);
    }
};

exports.createAccount = async (req, res) => {
    const { error } = validateSignup(req.body);
    if (error) return res.status(400).send(error.details[0].message);

    try {
        const existingAccount = await accountService.findByEmail(req.body.email);
        if (existingAccount.length > 0) {
            return res.status(400).send('Account with this email already exists');
        }
        req.body.password = await authService.hashPassword(req.body.password);
        const account = await accountService.create(req.body);
        const token = authService.generateAccessToken(account);
        res.status(201).json({ accessToken: token });
    } catch (error) {
        res.status(500).send(error.message);
    }
};

exports.login = async (req, res) => {
    const { error } = validateLogin(req.body);
    if (error) return res.status(400).send(error.details[0].message);

    try {
        const { email, password } = req.body;
        const account = await accountService.findByEmail(email);
        if (account.length === 0) {
            return res.status(404).send('Account not found');
        }
        if (await authService.comparePassword(password, account[0].password) === false){
            return res.status(401).send('Invalid password');
        }
        const token = authService.generateAccessToken(account[0]);
        res.json({ accessToken: token });
    } catch (error) {
        res.status(500).send(error.message);
    }
}
