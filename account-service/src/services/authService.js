const jwt = require('jsonwebtoken');

exports.generateAccessToken = (user) => {
    return jwt.sign({ username: user.username, id: user.id }, process.env.ACCESS_TOKEN_SECRET, { expiresIn: '1800s' });
};

exports.verifyPassword = (password, hash) => {
    // Logic to verify user password
};