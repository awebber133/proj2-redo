const express = require('express');
const app = express();
const port = 5000;

app.get('/', (req, res) => res.send('Hello World! This is the Node.js version!'));

app.listen(port, () => console.log(`App running on port ${port}`));
