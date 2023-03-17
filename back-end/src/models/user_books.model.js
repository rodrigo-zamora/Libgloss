var UserBooks = dynogels.define('UserBooks', {
    hashKey : 'UUID',
    timestamps : true,
    schema : {
        UUID            : dynogels.types.uuid(),
        authors         : dynogels.types.stringSet(),
        categories      : dynogels.types.stringSet(),
        images          : dynogels.types.stringSet(),
        isbn            : Joi.string(),
        latitude        : Joi.number(),
        longitude       : Joi.number(),
        price           : Joi.number(),
        publisher       : Joi.string(),
        sellerUUID      : dynogels.types.uuid(),
        thumbnail       : Joi.string(),
        title           : Joi.string(),
    }
});