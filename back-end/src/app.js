const express = require('express');

const app = express();

app.use(express.json());

app.use('/api/books', require('./routes/books.route'));

module.exports = app;