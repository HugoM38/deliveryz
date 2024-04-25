const express = require('express');
require('dotenv').config();
const orderRoutes = require('./src/api/routes/orderRoutes');
const errorHandler = require('./src/api/middleware/errorHandler');

const app = express();
const PORT = process.env.PORT || 3001;

app.use(express.json());
app.use('/', orderRoutes);
app.use(errorHandler);

app.listen(PORT, () => {
    console.log(`Account Service running on port ${PORT}`);
});
