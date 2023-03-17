var BookDetails = dynogels.define('BookDetails', {
    hashKey : 'UUID',
    timestamps : true,
    schema : {
        UUID            : Joi.string(),
        isbn            : Joi.string(),
        stores          : dynogels.types.stringSet(),
    }
});