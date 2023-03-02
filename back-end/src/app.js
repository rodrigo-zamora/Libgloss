require('dotenv').config();
const YAML = require('yamljs');
const swaggerUi = require('swagger-ui-express');
const path = require('path');
const express = require('express');
const {
    NotFoundError,
    ConflictError,
    BadRequestError,
    ForbiddenError,
    UnauthorizedError,
    NotImplementedError,
    ServerError
} = require('./utils/errors');

// Swagger documentation
const swaggerDocument = YAML.load(path.resolve('./src/docs/swagger.yaml'));

var app = express();

app.use(express.json());

// Routes and middlewares
app.use('/api/books', require('./routes/books.route'));
app.use('/', swaggerUi.serve, swaggerUi.setup(swaggerDocument));

app.use((err, req, res) => {
    if (err.details) return res.status(400).send(err.details[0].message);

    if (err instanceof NotFoundError) return res.status(404).send(err.message);
    if (err instanceof ConflictError) return res.status(409).send(err.message);
    if (err instanceof BadRequestError) return res.status(400).send(err.message);
    if (err instanceof ForbiddenError) return res.status(403).send(err.message);
    if (err instanceof UnauthorizedError) return res.status(401).send(err.message);
    if (err instanceof ServerError) return res.status(500).send(err.message);
    if (err instanceof NotImplementedError) return res.status(501).send(err.message);

    res.status(503).send('Something went wrong: ' + err.message);
});

module.exports = app;