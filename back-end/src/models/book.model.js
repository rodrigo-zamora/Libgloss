var Book = dynogels.define('Book', {
    hashKey : 'UUID',
    timestamps : true,
    schema : {
        UUID            : Joi.string(),
        title           : Joi.string(),
        subtitle        : Joi.string(),
        rating          : Joi.number(),
        thumbnail       : Joi.string(),
        language        : Joi.string(),
        isbn            : Joi.string(),
        authors         : dynogels.types.stringSet(),
        publisher       : Joi.string(),
        categories      : dynogels.types.stringSet(),
        description     : Joi.string(),
    }
});