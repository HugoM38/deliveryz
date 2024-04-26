const clientService = require('../../services/clientService');
const authService = require('../../services/authService');
const { validateSignupClient } = require('../validators/signupClientValidator');
const { validateLogin } = require('../validators/loginValidator');

exports.getAllClients = async (req, res) => {
    try {
        const clients = await clientService.findAll();
        res.json(clients);
    } catch (error) {
        res.status(500).send(error.message);
    }
};

exports.createClient = async (req, res) => {
    const { error } = validateSignupClient(req.body);
    if (error) return res.status(400).send(error.details[0].message);

    try {
        const existingClient = await clientService.findByEmail(req.body.email);
        if (existingClient.length > 0) {
            return res.status(400).send('Client with this email already exists');
        }
        req.body.password = await authService.hashPassword(req.body.password);
        const client = await clientService.create(req.body);
        const token = authService.generateAccessToken(client);
        res.status(201).json({ accessToken: token, id: client.id });
    } catch (error) {
        res.status(500).send(error.message);
    }
};

exports.loginClient = async (req, res) => {
    const { error } = validateLogin(req.body);
    if (error) return res.status(400).send(error.details[0].message);

    try {
        const { email, password } = req.body;
        const client = await clientService.findByEmail(email);
        if (client.length === 0) {
            return res.status(404).send('Client not found');
        }
        if (await authService.comparePassword(password, client[0].password) === false){
            return res.status(401).send('Invalid password');
        }
        const token = authService.generateAccessToken(client[0]);
        res.json({ accessToken: token, id: client[0].id});
    } catch (error) {
        res.status(500).send(error.message);
    }
}
