const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(bodyParser.json());

app.post('/calculate', (req, res) => {
    const { transportation, energy, diet } = req.body;
    const carbonFootprint = transportation * 0.21 + energy * 0.5 + diet * 2.5;
    res.json({ carbonFootprint });
});

app.get('/tips', (req, res) => {
    res.json({ tips: ["Walk instead of driving", "Use energy-efficient appliances", "Eat more plant-based meals"] });
});

app.listen(3000, () => console.log('Backend running on http://localhost:3000'));
