const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const saltRounds = 10;

exports.generateAccessToken = (user) => {
    return jwt.sign({ username: user.username, id: user.id }, process.env.ACCESS_TOKEN_SECRET, { expiresIn: '1800s' });
};

exports.hashPassword = async (password) => {
    try {
        const salt = await bcrypt.genSalt(saltRounds);
        const hash = await bcrypt.hash(password, salt);
        return hash;
    } catch (error) {
        throw new Error('Hashing failed', error);
    }
};

exports.comparePassword = async (password, hash) => {
    try {
        return await bcrypt.compare(password, hash);
    } catch (error) {
        throw new Error('Comparison failed', error);
    }
};