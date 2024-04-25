const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

require('dotenv').config();
const accountRoutes = require('./src/api/routes/kitchenRoutes');

const app = express();
const PORT = process.env.PORT || 3002;

app.use(express.json());
app.use(cors({
    origin: true, // Pour les tests de développement, permet à toutes les origines d'accéder à votre API
}));
app.use(bodyParser.json());
app.use('/', accountRoutes);

app.listen(PORT, () => {
    console.log(`Account Service running on port ${PORT}`);
});
