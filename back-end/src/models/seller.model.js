var Seller = dynogels.define('Seller', {
    hashKey : 'UUID',
    timestamps : true,
    schema : {
        UUID            : dynogels.types.uuid(),
        email           : Joi.string().email(),
        sellerName      : Joi.string(),
        phoneNumber     : Joi.string(),
    }
});