const express = require('express');
const cors = require('cors');
require('dotenv').config();
const accountRoutes = require('./src/api/routes/accountRoutes');

const app = express();
const PORT = process.env.PORT || 3003;

app.use(express.json());
app.use(cors({
    origin: true, // Pour les tests de développement, permet à toutes les origines d'accéder à votre API
}));
app.use('/', accountRoutes);

app.listen(PORT, () => {
    console.log(`Account Service running on port ${PORT}`);
});
