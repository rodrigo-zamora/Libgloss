var WishListItem = dynogels.define('WishListItem', {
    hashKey : 'UUID',
    schema : {
        UUID            : dynogels.types.uuid(),
        authors         : dynogels.types.stringSet(),
        isbn            : Joi.string(),
        thumbnail       : Joi.string(), 
        title           : Joi.string(),
    }
});