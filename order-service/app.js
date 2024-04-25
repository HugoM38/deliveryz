const express = require('express');
require('dotenv').config();
const cors = require('cors');
const orderRoutes = require('./src/api/routes/orderRoutes');
const errorHandler = require('./src/api/middleware/errorHandler');

const app = express();
const PORT = process.env.PORT || 3001;

app.use(express.json());
app.use(cors({
    origin: true, // Pour les tests de développement, permet à toutes les origines d'accéder à votre API
}));
app.use('/', orderRoutes);
app.use(errorHandler);

app.listen(PORT, () => {
    console.log(`Account Service running on port ${PORT}`);
});
