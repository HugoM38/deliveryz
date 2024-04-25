const express = require('express');
require('dotenv').config();
const accountRoutes = require('./src/api/routes/accountRoutes');

const app = express();
const PORT = process.env.PORT || 3003;

app.use(express.json());
app.use('/', accountRoutes);

app.listen(PORT, () => {
    console.log(`Account Service running on port ${PORT}`);
});
