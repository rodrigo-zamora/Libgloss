const Joi = require('joi');
const dynogels = require('../libs/dynogels');

var BookDetails = dynogels.define('BookDetails', {
    hashKey : 'id',
    schema : {
        id              : dynogels.types.uuid(),
        isbn            : Joi.string(),
        stores          : Joi.array().items(Joi.string()),
    }
});

module.exports = BookDetails;