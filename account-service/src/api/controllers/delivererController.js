const delivererService = require('../../services/delivererService');
const authService = require('../../services/authService');
const { validateSignupDeliverer } = require('../validators/signupDelivererValidator');
const { validateLogin } = require('../validators/loginValidator');

exports.getAllDeliverers = async (req, res) => {
    try {
        const deliverers = await delivererService.findAll();
        res.json(deliverers);
    } catch (error) {
        res.status(500).send(error.message);
    }
};

exports.createDeliverer = async (req, res) => {
    const { error } = validateSignupDeliverer(req.body);
    if (error) return res.status(400).send(error.details[0].message);

    try {
        const existingDeliverer = await delivererService.findByEmail(req.body.email);
        if (existingDeliverer.length > 0) {
            return res.status(400).send('Deliverer with this email already exists');
        }
        req.body.password = await authService.hashPassword(req.body.password);
        const deliverer = await delivererService.create(req.body);
        const token = authService.generateAccessToken(deliverer);
        res.status(201).json({ accessToken: token });
    } catch (error) {
        res.status(500).send(error.message);
    }
};

exports.loginDeliverer = async (req, res) => {
    const { error } = validateLogin(req.body);
    if (error) return res.status(400).send(error.details[0].message);

    try {
        const { email, password } = req.body;
        const deliverer = await delivererService.findByEmail(email);
        if (deliverer.length === 0) {
            return res.status(404).send('Deliverer not found');
        }
        if (await authService.comparePassword(password, deliverer[0].password) === false){
            return res.status(401).send('Invalid password');
        }
        const token = authService.generateAccessToken(deliverer[0]);
        res.json({ accessToken: token });
    } catch (error) {
        res.status(500).send(error.message);
    }
}
