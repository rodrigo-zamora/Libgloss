const app = require('./app');
const mongoose = require('mongoose');

// Get port from environment and store in Express.
const port = process.env.PORT || 3000;
app.set('port', port);

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
const admin = require('firebase-admin');
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
});

app.listen(port, () => {
    console.log(`Server is up on port ${port}`);
});