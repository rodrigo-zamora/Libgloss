require('dotenv').config();
const mongoose = require('mongoose');

const DB_NAME = process.env.DB_NAME || '';
const DB_USERNAME = process.env.DB_USERNAME || '';
const DB_PASSWORD = process.env.DB_PASSWORD || '';
const DB_CLUSTER = process.env.DB_CLUSTER || '';
const DB_DOMAIN_NAME = process.env.DB_DOMAIN_NAME || '';

const DB_URI = `mongodb+srv://${DB_USERNAME}:${DB_PASSWORD}@${DB_CLUSTER}.${DB_DOMAIN_NAME}/${DB_NAME}?retryWrites=true&w=majority`;

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

const express = require('express');

const app = express();

app.use(express.json());

app.use('/api/books', require('./routes/books.route'));

module.exports = app;