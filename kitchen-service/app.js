const express = require('express');
require('dotenv').config();
const accountRoutes = require('./src/api/routes/kitchenRoutes');

const app = express();
const PORT = process.env.PORT || 3002;

app.use(express.json());
app.use('/kitchen', accountRoutes);

app.listen(PORT, () => {
    console.log(`Account Service running on port ${PORT}`);
});
