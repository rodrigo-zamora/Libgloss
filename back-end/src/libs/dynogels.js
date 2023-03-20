const dynogels = require('dynogels');

const path = require('path');

dynogels.AWS.config.loadFromPath(path.resolve('credentials.json'));

module.exports = dynogels;