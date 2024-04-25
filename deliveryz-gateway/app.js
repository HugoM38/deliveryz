const express = require('express');
const { createProxyMiddleware } = require('http-proxy-middleware');
const jwt = require('jsonwebtoken');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

app.use('/accounts', createProxyMiddleware({
    target: 'http://localhost:3003', 
    changeOrigin: true,
    pathRewrite: {
        '^/accounts': '', 
    },
}));

app.use('/kitchens', authenticateToken, createProxyMiddleware({
    target: 'http://localhost:3002', 
    changeOrigin: true,
    pathRewrite: {
        '^/kitchens': '',
    },
}));

app.use('/orders', authenticateToken, createProxyMiddleware({
    target: 'http://localhost:3001', 
    changeOrigin: true,
    pathRewrite: {
        '^/orders': '',
    },
}));

app.listen(PORT, () => {
    console.log(`API Gateway running on port ${PORT}`);
});

function authenticateToken(req, res, next) {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];
    if (token == null) return res.sendStatus(401);

    jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, (err, user) => {
        if (err) return res.sendStatus(403);
        req.user = user;
        next();
    });
}