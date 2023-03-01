require('dotenv').config();
const mongoose = require('mongoose');
const YAML = require('yamljs');
const swaggerUi = require('swagger-ui-express');
const path = require('path');

// Database connection
const DB_NAME = process.env.DB_NAME || '';
const DB_USERNAME = process.env.DB_USERNAME || '';
const DB_PASSWORD = process.env.DB_PASSWORD || '';
const DB_CLUSTER = process.env.DB_CLUSTER || '';
const DB_DOMAIN_NAME = process.env.DB_DOMAIN_NAME || '';

const DB_URI = `mongodb+srv://${DB_USERNAME}:${DB_PASSWORD}@${DB_CLUSTER}.${DB_DOMAIN_NAME}/${DB_NAME}?retryWrites=true&w=majority`;

// Connect to MongoDB
mongoose.connect(DB_URI);

mongoose.connection.on('connected', function () {
    console.log('Mongoose connection open to ' + DB_URI);
});

mongoose.connection.on('error', function (err) {
    console.log('Mongoose connection error: ' + err);
});

mongoose.connection.on('disconnected', function () {
    console.log('Mongoose connection disconnected');
});

process.on('SIGINT', function () {
    mongoose.connection.close(function () {
        console.log('Mongoose connection disconnected through app termination');
        process.exit(0);
    });
});

// Firebase connection
/*const admin = require('firebase-admin');
const serviceAccount = {
    'type': 'service_account',
    'project_id': 'your-project-id',
    'private_key_id': process.env.FIREBASE_ADMIN_PRIVATE_KEY_ID,
    // See: https://stackoverflow.com/a/50376092/3403247.
    'private_key': "-----BEGIN PRIVATE KEY-----\n" + process.env.FIREBASE_ADMIN_PRIVATE_KEY.replace(/\\n/g, '\n') + "\n-----END PRIVATE KEY-----\n",
    'client_email': process.env.FIREBASE_ADMIN_CLIENT_EMAIL,
    'client_id': process.env.FIREBASE_ADMIN_CLIENT_ID,
    'auth_uri': 'https://accounts.google.com/o/oauth2/auth',
    'token_uri': 'https://oauth2.googleapis.com/token',
    'auth_provider_x509_cert_url': process.env.FIREBASE_ADMIN_AUTH_PROVIDER_X509_CERT_URL,
    'client_x509_cert_url': process.env.FIREBASE_ADMIN_CLIENT_X509_CERT_URL,
  };

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});*/

const express = require('express');

const app = express();

app.use(express.json());

const swaggerDocument = YAML.load(path.resolve('./src/docs/swagger.yaml'));

// Routes
app.use('/docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));
app.use('/api/books', require('./routes/books.route'));

// Error handling
const {
    NotFoundError,
    ConflictError,
    BadRequestError,
    ForbiddenError,
    UnauthorizedError,
    NotImplementedError,
    ServerError
} = require('./utils/errors');

app.use((err, req, res, next) => {
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