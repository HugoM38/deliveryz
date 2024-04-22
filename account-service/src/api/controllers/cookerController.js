const cookerService = require('../../services/cookerService');
const authService = require('../../services/authService');
const { validateSignupCooker } = require('../validators/signupCookerValidator');
const { validateLogin } = require('../validators/loginValidator');

exports.getAllCookers = async (req, res) => {
    try {
        const cookers = await cookerService.findAll();
        res.json(cookers);
    } catch (error) {
        res.status(500).send(error.message);
    }
};

exports.createCooker = async (req, res) => {
    const { error } = validateSignupCooker(req.body);
    if (error) return res.status(400).send(error.details[0].message);

    try {
        const existingCooker = await cookerService.findByEmail(req.body.email);
        if (existingCooker.length > 0) {
            return res.status(400).send('Cooker with this email already exists');
        }
        req.body.password = await authService.hashPassword(req.body.password);
        const cooker = await cookerService.create(req.body);
        const token = authService.generateAccessToken(cooker);
        res.status(201).json({ accessToken: token });
    } catch (error) {
        res.status(500).send(error.message);
    }
};

exports.loginCooker = async (req, res) => {
    const { error } = validateLogin(req.body);
    if (error) return res.status(400).send(error.details[0].message);

    try {
        const { email, password } = req.body;
        const cooker = await cookerService.findByEmail(email);
        if (cooker.length === 0) {
            return res.status(404).send('Cooker not found');
        }
        if (await authService.comparePassword(password, cooker[0].password) === false){
            return res.status(401).send('Invalid password');
        }
        const token = authService.generateAccessToken(cooker[0]);
        res.json({ accessToken: token });
    } catch (error) {
        res.status(500).send(error.message);
    }
}
