var TrackingListItem = dynogels.define('TrackingListItem', {
    hashKey : 'UUID',
    schema : {
        UUID            : dynogels.types.uuid(),
        authors         : dynogels.types.stringSet(),
        isbn            : Joi.string(),
        price           : Joi.number(),
        store           : Joi.string(),
        thumbnail       : Joi.string(), 
        time            : Joi.number(),
        title           : Joi.string(),
    }
});