const dynogels = require('../libs/dynogels');
const Joi = require('joi');

var Book = dynogels.define('Book', {
    hashKey : 'id',

    schema : {
        id              : dynogels.types.uuid(),
        title           : Joi.string(),
        subtitle        : Joi.string(),
        rating          : Joi.number(),
        thumbnail       : Joi.string(),
        language        : Joi.string(),
        isbn            : Joi.string(),
        authors         : Joi.array().items(Joi.string()),
        publisher       : Joi.string(),
        categories      : Joi.array().items(Joi.string()),
        description     : Joi.string(),
    }
});

module.exports = Book;