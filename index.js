const express = require('express');
const app = express();
const PORT = 8080;

app.use(express.json())

app.listen(
    PORT,
    () => console.log(`it's alive on http://localhost:${PORT}`)
);

// Generates random seed
let seedGen = Math.random().toString(36).substr(2, 3) + Math.random().toString(36).substr(2, 3) + Math.random().toString(36).substr(2, 3) + Math.random().toString(36).substr(2, 3) + Math.random(36).toString().substr(2, 4);

app.get('/seed', (req, res) => {
    res.status(200).send({
        seed: seedGen,
        description: 'seed generated'
    })
});
